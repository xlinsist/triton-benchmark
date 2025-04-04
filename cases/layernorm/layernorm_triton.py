# Refer to: https://github.com/FlagOpen/FlagGems/blob/master/src/flag_gems/ops/layernorm.py

import math
import os
import time

import numpy as np
import torch
import triton
import triton.language as tl


"""
config in: https://github.com/FlagOpen/FlagGems/blob/master/src/flag_gems/runtime/backend/_metax/tune_configs.yaml#L512
only retain the TILE_N part on triton-cpu
"""
layer_norm_persistent_configs = [
    triton.Config(
        {},
    ),
]

"""
config in: https://github.com/FlagOpen/FlagGems/blob/master/src/flag_gems/runtime/backend/_metax/tune_configs.yaml#L521
only retain the TILE_N part on triton-cpu
layer_norm_loop:
  tile_n:
  - 1024
  - 2048
  - 4096
  - 8192
"""
layer_norm_loop_configs = [
    triton.Config(
        {"TILE_N": 1024},
    ),
    triton.Config(
        {"TILE_N": 2048},
    ),
    triton.Config(
        {"TILE_N": 4096},
    ),
    triton.Config(
        {"TILE_N": 8192},
    ),
]


@triton.jit
def prev_multiple_of(a, b):
    # the largest x<a that x%b ==0
    return tl.cdiv(a, b) * b - b


@triton.autotune(
    configs=layer_norm_persistent_configs,
    key=["M", "N"],
)
@triton.jit(do_not_specialize=["eps"])
def layer_norm_persistent_kernel(
    in_ptr,
    out_ptr,
    weight_ptr,
    bias_ptr,
    out_mean_ptr,  # pointer to the mean
    out_rstd_ptr,  # pointer to the 1/std
    M,
    N,
    eps,
    TILE_N: tl.constexpr,
):
    # using 1d tile makes code clean
    # Map the program id to the row of X and Y it should compute.
    pid = tl.program_id(0)

    n_offsets = tl.arange(0, TILE_N)
    mask = n_offsets < N

    x = tl.load(in_ptr + pid * N + n_offsets, mask, other=0.0).to(tl.float32)
    m = tl.sum(x) / N
    d = x - m  # deviation
    s = tl.where(mask, d * d, 0)
    sum_square = tl.sum(s)  # sum of square of deviation
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


@triton.autotune(
    configs=layer_norm_persistent_configs,
    key=["M", "N"],
)
@triton.jit(do_not_specialize=["eps"])
def layer_norm_persistent_kernel_multiline(
    in_ptr,
    out_ptr,
    weight_ptr,
    bias_ptr,
    out_mean_ptr,  # pointer to the mean
    out_rstd_ptr,  # pointer to the 1/std
    M,
    N,
    eps,
    TILE_M: tl.constexpr,
    TILE_N: tl.constexpr,
):
    # Map the program id to the row of X and Y it should compute.
    pid = tl.program_id(0)  # 改为使用原版tl获取
    m_offsets = pid * TILE_M + tl.arange(0, TILE_M)
    m_mask = m_offsets < M

    n_offsets = tl.arange(0, TILE_N)[None, :]
    n_mask = n_offsets < N
    mask = m_mask[:, None] & n_mask

    x = tl.load(in_ptr + m_offsets[:, None] * N + n_offsets, mask, other=0.0).to(
        tl.float32
    )
    m = tl.sum(x, axis=1) / N
    d = x - m[:, None]  # deviation
    s = tl.where(mask, d * d, 0)
    sum_square = tl.sum(s, axis=1)  # sum of square of deviation
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


@triton.autotune(
    configs=layer_norm_loop_configs,
    key=["M", "N"],
)
@triton.jit(do_not_specialize=["eps"])
def layer_norm_loop_kernel(
    in_ptr,
    out_ptr,
    weight_ptr,
    bias_ptr,
    out_mean_ptr,  # pointer to the mean
    out_rstd_ptr,  # pointer to the 1/std
    M,
    N,
    eps,
    TILE_N: tl.constexpr,
):
    # Map the program id to the row of X and Y it should compute.
    pid = tl.program_id(0)  # 改为使用原版tl获取

    # Compute mean
    m = tl.zeros((TILE_N,), dtype=tl.float32)  # mean
    s = tl.zeros((TILE_N,), dtype=tl.float32)  # sum((x - m)^2)
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

    # the last step
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
    # Write mean / rstd
    tl.store(out_mean_ptr + pid, m)
    tl.store(out_rstd_ptr + pid, rstd)

    # reverse the order of the second sweep
    # Normalize and apply linear transformation
    prev_multiple = prev_multiple_of(N, TILE_N)
    # the first step, masking is needed
    for start_n in range(0, TILE_N, TILE_N):
        n_offsets = (prev_multiple - start_n) + tl.arange(0, TILE_N)
        mask = n_offsets < N
        x = tl.load(
            in_ptr + pid * N + n_offsets,
            mask=mask,
            other=0.0,
            eviction_policy="evict_first",
        ).to(tl.float32)
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
        x = tl.load(in_ptr + pid * N + n_offsets, eviction_policy="evict_first").to(
            tl.float32
        )
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
    # dim = x.ndim - len(normalized_shape)
    # M = math.prod(x.shape[:dim])
    N = math.prod(normalized_shape)
    M = x.numel() // N

    x = x.contiguous()
    if weight is not None:
        weight = weight.contiguous()
    if bias is not None:
        bias = bias.contiguous()
    y = torch.empty_like(x)

    # NOTE: when the input is half-precision(either float16 or bfloat16)
    # these statistical data saved for backward is in single precision
    acc_type = x.dtype
    mean = torch.empty(M, dtype=acc_type, device=x.device)
    rstd = torch.empty(M, dtype=acc_type, device=x.device)

    if N <= 128:
        TILE_N = triton.next_power_of_2(N)
        TILE_M = triton.cdiv(1024, TILE_N)
        grid = (triton.cdiv(M, TILE_M), 1, 1)
        layer_norm_persistent_kernel_multiline[grid](
            x,
            y,
            weight,
            bias,
            mean,
            rstd,
            M,
            N,
            eps,
            TILE_M,
            TILE_N,
        )
    elif N <= 4096:
        TILE_N = triton.next_power_of_2(N)
        grid = (M, 1, 1)
        layer_norm_persistent_kernel[grid](
            x,
            y,
            weight,
            bias,
            mean,
            rstd,
            M,
            N,
            eps,
            TILE_N,
        )
    else:
        grid = (M, 1, 1)
        layer_norm_loop_kernel[grid](
            x,
            y,
            weight,
            bias,
            mean,
            rstd,
            M,
            N,
            eps,
        )

    return y, mean, rstd


def layer_norm(x, normalized_shape, weight=None, bias=None, eps=1e-5):
    return LayerNorm(x, normalized_shape, weight, bias, eps)


def benchmark_triton(shape, a_np, parallel=True):
    os.environ["TRITON_CPU_BACKEND"] = "1"
    os.environ["TRITON_CPU_MAX_THREADS"] = "0" if parallel else "1"

    M, N = shape
    a = torch.tensor(a_np, device="cpu", dtype=torch.float32)
    assert a.is_contiguous(), "Matrix A must be contiguous"

    times = []
    for _ in range(10):
        start = time.perf_counter()
        result, _, _ = layer_norm(a, (a.shape[1],))
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), result.numpy()


def benchmark_triton_single(shape, a_np):
    return benchmark_triton(shape, a_np, parallel=False)


if __name__ == "__main__":
    #################### unit test ####################
    np.random.seed(0)
    M, N = 512, 512
    shape = (M, N)
    a_np = np.random.rand(M, N).astype(np.float32)
    a = torch.tensor(a_np, device="cpu", dtype=torch.float32)
    assert a.is_contiguous(), "Matrix A must be contiguous"

    # triton
    time_triton, result = benchmark_triton(shape, a_np)
    print("time_triton", time_triton)
    print("result", result)

    # triton_single
    time_triton_single, result_single = benchmark_triton_single(shape, a_np)
    print("time_triton_single", time_triton_single)
    print("result_single", result_single)

    # torch
    start = time.perf_counter()
    with torch.no_grad():
        result_torch = torch.nn.LayerNorm(a.shape[1])(a)
    end = time.perf_counter()

    print(end - start)
    print("result_torch", result_torch)

    # compare
    if np.allclose(result, result_torch, atol=1e-3, rtol=1e-3):
        print("pass")
    else:
        print("fail")
        print("max diff", np.abs(result - result_torch).max())
