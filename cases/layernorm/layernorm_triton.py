# Refer to: https://github.com/FlagOpen/FlagGems/blob/master/src/flag_gems/ops/layernorm.py

import math
import os
import time
import multiprocessing

import numpy as np
import torch
import triton
import triton.language as tl

triton.runtime.driver.set_active_to_cpu()

def get_layernorm_kernel_autotune_config(num_threads=0):
    # Persistent kernel configs
    persistent_configs = []
    for TILE_N in [64, 128, 256, 512, 1024, 2048, 4096]:
        persistent_configs.append(triton.Config({'TILE_N': TILE_N}))
    
    # Loop kernel configs
    loop_configs = []
    for TILE_N in [1024, 2048, 4096, 8192]:
        loop_configs.append(triton.Config({'TILE_N': TILE_N}))
    
    if os.getenv("ENABLE_AUTOTUNING") == "layernorm_kernel":
        assert (len(persistent_configs) > 1 and len(loop_configs) > 1), "Autotuning config size needs to be larger than 1"
        return {
            "persistent": persistent_configs,
            "loop": loop_configs
        }
    
    return {
        "persistent": [triton.Config({'TILE_N': 1024})],
        "loop": [triton.Config({'TILE_N': 4096})]
    }

@triton.jit
def prev_multiple_of(a, b):
    return tl.cdiv(a, b) * b - b

def layer_norm_persistent_kernel(
    in_ptr,
    out_ptr,
    weight_ptr,
    bias_ptr,
    out_mean_ptr,
    out_rstd_ptr,
    M,
    N,
    eps,
    TILE_N: tl.constexpr,
):
    pid = tl.program_id(0)
    n_offsets = tl.arange(0, TILE_N)
    mask = n_offsets < N

    x = tl.load(in_ptr + pid * N + n_offsets, mask, other=0.0).to(tl.float32)
    m = tl.sum(x) / N
    d = x - m
    s = tl.where(mask, d * d, 0)
    sum_square = tl.sum(s)
    var = sum_square / N
    rstd = tl.math.rsqrt(var + eps)

    tl.store(out_mean_ptr + pid, m)
    tl.store(out_rstd_ptr + pid, rstd)

    if weight_ptr is None:
        w = 1
    else:
        w = tl.load(weight_ptr + n_offsets, mask=mask)
    if bias_ptr is None:
        b = 0
    else:
        b = tl.load(bias_ptr + n_offsets, mask=mask)
    out = (x - m) * rstd * w + b

    tl.store(out_ptr + pid * N + n_offsets, out, mask=mask)

def layer_norm_persistent_kernel_multiline(
    in_ptr,
    out_ptr,
    weight_ptr,
    bias_ptr,
    out_mean_ptr,
    out_rstd_ptr,
    M,
    N,
    eps,
    TILE_M: tl.constexpr,
    TILE_N: tl.constexpr,
):
    pid = tl.program_id(0)
    m_offsets = pid * TILE_M + tl.arange(0, TILE_M)
    m_mask = m_offsets < M

    n_offsets = tl.arange(0, TILE_N)[None, :]
    n_mask = n_offsets < N
    mask = m_mask[:, None] & n_mask

    x = tl.load(in_ptr + m_offsets[:, None] * N + n_offsets, mask, other=0.0).to(tl.float32)
    m = tl.sum(x, axis=1) / N
    d = x - m[:, None]
    s = tl.where(mask, d * d, 0)
    sum_square = tl.sum(s, axis=1)
    var = sum_square / N
    rstd = tl.math.rsqrt(var + eps)

    tl.store(out_mean_ptr + m_offsets, m, mask=m_mask)
    tl.store(out_rstd_ptr + m_offsets, rstd, mask=m_mask)

    if weight_ptr is None:
        w = 1
    else:
        w = tl.load(weight_ptr + n_offsets, mask=n_mask)
    if bias_ptr is None:
        b = 0
    else:
        b = tl.load(bias_ptr + n_offsets, mask=n_mask)
    out = (x - m[:, None]) * rstd[:, None] * w + b

    tl.store(out_ptr + m_offsets[:, None] * N + n_offsets, out, mask=mask)

def layer_norm_loop_kernel(
    in_ptr,
    out_ptr,
    weight_ptr,
    bias_ptr,
    out_mean_ptr,
    out_rstd_ptr,
    M,
    N,
    eps,
    TILE_N: tl.constexpr,
):
    pid = tl.program_id(0)
    m = tl.zeros((TILE_N,), dtype=tl.float32)
    s = tl.zeros((TILE_N,), dtype=tl.float32)
    cnt = tl.zeros((TILE_N,), dtype=tl.int32)
    num_steps = tl.cdiv(N, TILE_N)
    
    for step in range(0, num_steps - 1, 1):
        start_n = step * TILE_N
        n_offsets = start_n + tl.arange(0, TILE_N)
        x = tl.load(in_ptr + pid * N + n_offsets).to(tl.float32)
        new_m = m + (x - m) / (step + 1)
        new_s = s + (x - new_m) * (x - m)
        cnt += 1
        m = new_m
        s = new_s

    for step in range(num_steps - 1, num_steps, 1):
        start_n = step * TILE_N
        n_offsets = start_n + tl.arange(0, TILE_N)
        mask = n_offsets < N
        x = tl.load(in_ptr + pid * N + n_offsets, mask=mask).to(tl.float32)
        new_m = tl.where(mask, m + (x - m) / (step + 1), m)
        new_s = tl.where(mask, s + (x - new_m) * (x - m), s)
        cnt += mask.to(tl.int32)
        m = new_m
        s = new_s

    final_m = tl.sum(m * cnt) / N
    var = tl.sum(s + cnt * (m - final_m) * (m - final_m)) / N
    rstd = tl.math.rsqrt(var + eps)
    m = final_m
    
    tl.store(out_mean_ptr + pid, m)
    tl.store(out_rstd_ptr + pid, rstd)

    prev_multiple = prev_multiple_of(N, TILE_N)
    for start_n in range(0, TILE_N, TILE_N):
        n_offsets = (prev_multiple - start_n) + tl.arange(0, TILE_N)
        mask = n_offsets < N
        x = tl.load(in_ptr + pid * N + n_offsets, mask=mask, other=0.0).to(tl.float32)
        if weight_ptr is None:
            w = 1
        else:
            w = tl.load(weight_ptr + n_offsets, mask=mask)
        if bias_ptr is None:
            b = 0
        else:
            b = tl.load(bias_ptr + n_offsets, mask=mask)
        out = w * (x - m) * rstd + b
        tl.store(out_ptr + pid * N + n_offsets, out, mask=mask)

    for start_n in range(TILE_N, N, TILE_N):
        n_offsets = (prev_multiple - start_n) + tl.arange(0, TILE_N)
        x = tl.load(in_ptr + pid * N + n_offsets).to(tl.float32)
        if weight_ptr is None:
            w = 1
        else:
            w = tl.load(weight_ptr + n_offsets)
        if bias_ptr is None:
            b = 0
        else:
            b = tl.load(bias_ptr + n_offsets)
        out = w * (x - m) * rstd + b
        tl.store(out_ptr + pid * N + n_offsets, out)

def LayerNorm(x, normalized_shape, weight, bias, eps=1e-5):
    N = math.prod(normalized_shape)
    M = x.numel() // N

    x = x.contiguous()
    if weight is not None:
        weight = weight.contiguous()
    if bias is not None:
        bias = bias.contiguous()
    y = torch.empty_like(x)

    acc_type = x.dtype
    mean = torch.empty(M, dtype=acc_type, device=x.device)
    rstd = torch.empty(M, dtype=acc_type, device=x.device)

    # Get autotune configs
    autotune_configs = get_layernorm_kernel_autotune_config()
    
    if N <= 128:
        TILE_N = triton.next_power_of_2(N)
        TILE_M = triton.cdiv(1024, TILE_N)
        grid = (triton.cdiv(M, TILE_M), 1, 1)
        
        # Create autotuner for multiline kernel
        kernel_fn = triton.jit(layer_norm_persistent_kernel_multiline)
        autotuner = triton.runtime.Autotuner(
            kernel_fn,
            kernel_fn.arg_names,
            configs=autotune_configs["persistent"],
            key=["M", "N"]
        )
        
        # Run with autotuning
        autotuner[grid](
            x, y, weight, bias, mean, rstd,
            M, N, eps, TILE_M, TILE_N
        )
    elif N <= 4096:
        TILE_N = triton.next_power_of_2(N)
        grid = (M, 1, 1)
        
        # Create autotuner for persistent kernel
        kernel_fn = triton.jit(layer_norm_persistent_kernel)
        autotuner = triton.runtime.Autotuner(
            kernel_fn,
            kernel_fn.arg_names,
            configs=autotune_configs["persistent"],
            key=["M", "N"]
        )
        
        # Run with autotuning
        autotuner[grid](
            x, y, weight, bias, mean, rstd,
            M, N, eps, TILE_N
        )
    else:
        grid = (M, 1, 1)
        
        # Create autotuner for loop kernel
        kernel_fn = triton.jit(layer_norm_loop_kernel)
        autotuner = triton.runtime.Autotuner(
            kernel_fn,
            kernel_fn.arg_names,
            configs=autotune_configs["loop"],
            key=["M", "N"]
        )
        
        # Run with autotuning
        autotuner[grid](
            x, y, weight, bias, mean, rstd,
            M, N, eps
        )

    return y, mean, rstd

def benchmark_triton(shape, a_np, parallel=True):
    M, N = shape
    a = torch.tensor(a_np, device="cpu", dtype=torch.float32)
    assert a.is_contiguous(), "Matrix A must be contiguous"

    # Set number of threads
    torch.set_num_threads(multiprocessing.cpu_count() if parallel else 1)

    # First run for tuning
    tuning_before = time.perf_counter()
    result, _, _ = LayerNorm(a, (a.shape[1],), None, None)
    tuning_after = time.perf_counter()
    tuning_time = tuning_after - tuning_before

    # Warm up
    for _ in range(25):
        result, _, _ = LayerNorm(a, (a.shape[1],), None, None)

    # Benchmark
    times = []
    for _ in range(100):
        start = time.perf_counter()
        result, _, _ = LayerNorm(a, (a.shape[1],), None, None)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), result.numpy(), tuning_time

def benchmark_triton_single(shape, a_np):
    return benchmark_triton(shape, a_np, parallel=False)

if __name__ == "__main__":
    np.random.seed(0)
    M, N = 512, 512
    shape = (M, N)
    a_np = np.random.rand(M, N).astype(np.float32)
    
    # Benchmark triton with parallel
    time_triton, result_triton, tuning_time = benchmark_triton(shape, a_np)
    
    # Benchmark triton single thread
    time_triton_single, result_triton_single, tuning_time_single = benchmark_triton_single(shape, a_np)
    
    # Verify results match
    assert np.allclose(result_triton, result_triton_single, atol=1e-3, rtol=1e-3), "triton result mismatch!"
    
    # Benchmark torch
    a = torch.tensor(a_np, device="cpu", dtype=torch.float32)
    start = time.perf_counter()
    with torch.no_grad():
        result_torch = torch.nn.LayerNorm(a.shape[1])(a)
    torch_time = time.perf_counter() - start
    
    # Print results
    print(f"Triton parallel time: {time_triton} Tuning Time: {tuning_time}")
    print(f"Triton single thread time: {time_triton_single} Tuning Time: {tuning_time_single}")
    print(f"Torch time: {torch_time}")
    
    # Verify against torch
    if np.allclose(result_triton, result_torch.numpy(), atol=1e-3, rtol=1e-3):
        print("Results match with torch")
    else:
        print("Results differ from torch")
        print("Max diff:", np.abs(result_triton - result_torch.numpy()).max())