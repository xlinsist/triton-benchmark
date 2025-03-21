# Refer to: https://github.com/triton-lang/triton-cpu/blob/main/python/tutorials/01-vector-add.py

import torch
import numpy as np
import triton
import triton.language as tl
import time
import os

DEFAULT_BLOCK_SIZE = 1024
DEFAULT_TILE_SIZE = 16


@triton.autotune(
    configs=[
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 128, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 4096}, num_threads=1),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 4096}, num_threads=1),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 4096}, num_threads=1),
        triton.Config({'TILE_SIZE': 128, 'BLOCK_SIZE': 4096}, num_threads=1),
    ],
    key=['n_elements'],
)
@triton.jit
def add_kernel(x_ptr,  # *Pointer* to first input vector.
                     y_ptr,  # *Pointer* to second input vector.
                     output_ptr,  # *Pointer* to output vector.
                     n_elements,  # Size of the vector.
                     BLOCK_SIZE: tl.constexpr,  # Number of elements each program should process.
                     TILE_SIZE: tl.constexpr,  # Number of elements each iteration should process.
                     ):
    pid = tl.program_id(axis=0)
    block_start = pid * BLOCK_SIZE
    for i in range(0, tl.cdiv(BLOCK_SIZE, TILE_SIZE)):
        offsets = block_start + i * TILE_SIZE + tl.arange(0, TILE_SIZE)
        mask = offsets < n_elements
        x = tl.load(x_ptr + offsets, mask=mask)
        y = tl.load(y_ptr + offsets, mask=mask)
        output = x + y
        tl.store(output_ptr + offsets, output, mask=mask)


def add(x: torch.Tensor, y: torch.Tensor, output: torch.Tensor):
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    # add_kernel[grid](x, y, output, n_elements, BLOCK_SIZE=DEFAULT_BLOCK_SIZE, TILE_SIZE=DEFAULT_TILE_SIZE)
    add_kernel[grid](x, y, output, n_elements)
    return output


def benchmark_triton(N, a_np, b_np):
    os.environ["TRITON_CPU_BACKEND"] = "1"
    triton.runtime.driver.set_active_to_cpu()

    a = torch.tensor(a_np, device='cpu', dtype=torch.float32)
    b = torch.tensor(b_np, device='cpu', dtype=torch.float32)
    c = torch.empty_like(a)

    times = []
    for _ in range(10):
        start = time.perf_counter()
        add(a, b, c)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy()


if __name__ == "__main__":
    N = 1024 * 1024
    a_np = np.random.rand(N).astype(np.float32)
    b_np = np.random.rand(N).astype(np.float32)
    time_triton, result_triton = benchmark_triton(N, a_np, b_np)
    print(f"triton time: {time_triton}")
