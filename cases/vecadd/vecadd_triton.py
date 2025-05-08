import torch
import numpy as np
import triton
import triton.language as tl
import time
import os
os.environ["TRITON_PRINT_AUTOTUNING"] = "1"
os.environ["TRITON_CPU_BACKEND"] = "1"
triton.runtime.driver.set_active_to_cpu()


# Triton Benchmark
def get_vector_add_kernel_autotune_config(num_threads=0):
    configs = []
    for BLOCK_SIZE in [1024,2048,4096, 8192, 16384]:
        for TILE_SIZE in [16, 32, 64, 128]:
            configs.append(triton.Config({'BLOCK_SIZE': BLOCK_SIZE, 'TILE_SIZE': TILE_SIZE}, num_threads=num_threads))
    return configs


def triton_vector_add_kernel(
        x_ptr,
        y_ptr,
        output_ptr,
        n_elements,
        BLOCK_SIZE: tl.constexpr,
        TILE_SIZE: tl.constexpr,
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


def benchmark_triton(N, a_np, b_np, parallel=True):
    fn = triton_vector_add_kernel
    fn_jit = triton.jit(fn)

    tune_start = time.perf_counter()
    fn_jit_tuned = triton.runtime.Autotuner(fn_jit, fn_jit.arg_names, reset_to_zero=None, restore_value=None,
                                            configs=get_vector_add_kernel_autotune_config(0 if parallel else 1),
                                            key=[],
                                            )
    tune_end = time.perf_counter()
    tuning_time = tune_end - tune_start

    a = torch.tensor(a_np, device='cpu', dtype=torch.float32)
    b = torch.tensor(b_np, device='cpu', dtype=torch.float32)
    c = torch.empty_like(a)
    grid = lambda META: (triton.cdiv(N, META['BLOCK_SIZE']),)

    # Warm-up
    fn_jit_tuned[grid](a, b, c, N)

    times = []
    for _ in range(10):
        start = time.perf_counter()
        fn_jit_tuned[grid](a, b, c, N)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy(), tuning_time


def benchmark_triton_single(N, a_np, b_np):
    return benchmark_triton(N, a_np, b_np, parallel=False)


if __name__ == "__main__":
    N = 1024 * 1024
    a_np = np.random.rand(N).astype(np.float32)
    b_np = np.random.rand(N).astype(np.float32)
    time_triton, result_triton, tuning_time_triton = benchmark_triton(N, a_np, b_np)
    time_triton_single, result_triton_single, tuning_time_triton_single = benchmark_triton_single(N, a_np, b_np)
    assert np.allclose(result_triton, result_triton_single, atol=1e-3, rtol=1e-3), f"triton result mismatch!"
    print(result_triton)
    print(result_triton_single)
    print(f"triton: {time_triton}, triton_single: {time_triton_single}")
    print(f"triton tuning time: {tuning_time_triton}, triton_single tuning time: {tuning_time_triton_single}")

