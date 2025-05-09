# Refer to: https://github.com/triton-lang/triton-cpu/blob/main/python/tutorials/03-matrix-multiplication-cpu.py

import torch
import numpy as np
import triton
import triton.language as tl
import time
import os
import multiprocessing

triton.runtime.driver.set_active_to_cpu()

def get_softmax_kernel_autotune_config(num_threads = 0):
    configs = []
    for BLOCK_SIZE in [64, 256, 1024, 4096, 16384, 65536]:
      for TILE_SIZE in [8, 16, 32, 64, 128]:
        configs.append(triton.Config({'BLOCK_SIZE': BLOCK_SIZE, 'TILE_SIZE': TILE_SIZE}))
    if(os.getenv("ENABLE_AUTOTUNING") == "softmax_kernel"):
      assert (len(configs) > 1), "Autotuning config size need be larger than 1"
      return configs

    return [triton.Config({'BLOCK_SIZE': 1024, 'TILE_SIZE': 16})]

def softmax_kernel(input_ptr, output_ptr, n_cols, input_row_stride, output_row_stride,
                   BLOCK_SIZE: tl.constexpr, TILE_SIZE: tl.constexpr):
    row_idx = tl.program_id(0)  # 每个线程块处理一行
    row_start_ptr = input_ptr + row_idx * input_row_stride  
    output_row_start_ptr = output_ptr + row_idx * output_row_stride  

    # 初始化 softmax 计算的最大值和总和
    acc_max = -float('inf')
    acc_sum = 0.0

    # 分块计算 max 值（全局归约）
    for block_start in range(0, n_cols, BLOCK_SIZE):
        for tile_start in range(0, BLOCK_SIZE, TILE_SIZE):
            col_offsets = tile_start + tl.arange(0, TILE_SIZE)  
            col_mask = (col_offsets + block_start) < n_cols  
            input_ptrs = row_start_ptr + block_start + col_offsets
            row = tl.load(input_ptrs, mask=col_mask, other=-float('inf'))
            acc_max = tl.maximum(acc_max, tl.max(row, axis=0))  # 归约最大值

    # 分块计算 sum(exp(row - max))（全局归约）
    for block_start in range(0, n_cols, BLOCK_SIZE):
        for tile_start in range(0, BLOCK_SIZE, TILE_SIZE):
            col_offsets = tile_start + tl.arange(0, TILE_SIZE)  
            col_mask = (col_offsets + block_start) < n_cols  
            input_ptrs = row_start_ptr + block_start + col_offsets
            row = tl.load(input_ptrs, mask=col_mask, other=-float('inf'))
            row_minus_max = row - acc_max  # 减去全局最大值
            numerator = tl.exp(row_minus_max)
            acc_sum += tl.sum(numerator, axis=0)  # 归约 sum(exp)

    # 计算 softmax 并写回
    for block_start in range(0, n_cols, BLOCK_SIZE):
        for tile_start in range(0, BLOCK_SIZE, TILE_SIZE):
            col_offsets = tile_start + tl.arange(0, TILE_SIZE)  
            col_mask = (col_offsets + block_start) < n_cols  
            input_ptrs = row_start_ptr + block_start + col_offsets
            output_ptrs = output_row_start_ptr + block_start + col_offsets

            row = tl.load(input_ptrs, mask=col_mask, other=-float('inf'))
            row_minus_max = row - acc_max
            numerator = tl.exp(row_minus_max)
            softmax_output = numerator / acc_sum  # 归一化
            tl.store(output_ptrs, softmax_output, mask=col_mask)


def benchmark_triton(shape, a_np, parallel=True):
    fn = softmax_kernel
    fn_jit = triton.jit(fn)
    fn_jit_tuned = triton.runtime.Autotuner(fn_jit, fn_jit.arg_names, 
        reset_to_zero=None, 
        restore_value=None,
        configs=get_softmax_kernel_autotune_config(0 if parallel else 1),
        key=[],
    )
    M, N = shape
    a = torch.tensor(a_np, dtype=torch.float32, device="cpu").contiguous()
    b = torch.empty((M, N), dtype=torch.float32, device="cpu")
    torch.set_num_threads(multiprocessing.cpu_count())

    def run_triton_kernel():
        fn_jit_tuned[(M, )](
            a, b, N,
            a.stride(0), a.stride(1),
        )

    # Get tuning time.
    tuning_before = time.perf_counter()
    run_triton_kernel()
    tuning_after = time.perf_counter()
    tuning_time = tuning_after - tuning_before

    # Warm up.
    for _ in range(25):
        run_triton_kernel()

    times = []
    # Repeat to execute.
    for _ in range(100):
        start = time.perf_counter()
        run_triton_kernel()
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), b.numpy(), tuning_time


def benchmark_triton_single(shape, a_np):
    return benchmark_triton(shape, a_np, parallel=False)


if __name__ == "__main__":
    M = N = 512
    a_np = np.random.rand(M, N).astype(np.float32)
    shape = (M, N)
    time_triton, result_triton, tuning_time = benchmark_triton(shape, a_np)
    time_triton_single, result_triton_single, tuning_time_single = benchmark_triton_single(shape, a_np)
    assert np.allclose(result_triton, result_triton_single, atol=1e-3, rtol=1e-3), f"triton result mismatch!"
    print(result_triton)
    print(result_triton_single)
    print(f"triton: {time_triton} Tuning Time:{tuning_time}") 
    print(f"triton_single: {time_triton_single} Tuning Time:{tuning_time_single}")
