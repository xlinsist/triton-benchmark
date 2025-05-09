# Refer to: https://github.com/triton-lang/triton-cpu/blob/main/python/tutorials/03-matrix-multiplication-cpu.py

import torch
import numpy as np
import triton
import triton.language as tl
import time
import os
import multiprocessing

triton.runtime.driver.set_active_to_cpu()

# Triton Benchmark
def get_matmul_kernel_autotune_config(num_threads = 0):
    configs=[]
    for BLOCK_SIZE_M in [16, 32, 64]:
        for BLOCK_SIZE_N in [16, 32, 64]:
            for BLOCK_SIZE_K in [32, 64, 128]:
                configs.append(triton.Config({'BLOCK_SIZE_M': BLOCK_SIZE_M, 'BLOCK_SIZE_N': BLOCK_SIZE_N, 'BLOCK_SIZE_K': BLOCK_SIZE_K}, num_threads = num_threads))
    return configs


def triton_matmul_kernel(
        # Pointers to matrices
        a_ptr, b_ptr, c_ptr,
        # Matrix dimensions
        M, N, K,
        # The stride variables represent how much to increase the ptr by when moving by 1
        # element in a particular dimension. E.g. `stride_am` is how much to increase `a_ptr`
        # by to get the element one row down (A has M rows).
        stride_am, stride_ak,  #
        stride_bk, stride_bn,  #
        stride_cm, stride_cn,
        # Meta-parameters
        BLOCK_SIZE_M: tl.constexpr, BLOCK_SIZE_N: tl.constexpr, BLOCK_SIZE_K: tl.constexpr  #
):
    """Kernel for computing the matmul C = A x B.
    A has shape (M, K), B has shape (K, N) and C has shape (M, N)
    """
    # -----------------------------------------------------------
    # Map program ids `pid` to the block of C it should compute.

    pid = tl.program_id(axis=0)
    num_pid_n = tl.cdiv(N, BLOCK_SIZE_N)
    pid_m = pid // num_pid_n
    pid_n = pid % num_pid_n

    # ----------------------------------------------------------
    # Create pointers for the first blocks of A and B.
    # We will advance this pointer as we move in the K direction
    # and accumulate
    # `a_ptrs` is a block of [BLOCK_SIZE_M, BLOCK_SIZE_K] pointers
    # `b_ptrs` is a block of [BLOCK_SIZE_K, BLOCK_SIZE_N] pointers
    # See above `Pointer Arithmetics` section for details
    offs_am = (pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)) % M
    offs_bn = (pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)) % N
    offs_k = tl.arange(0, BLOCK_SIZE_K)
    a_ptrs = a_ptr + (offs_am[:, None] * stride_am + offs_k[None, :] * stride_ak)
    b_ptrs = b_ptr + (offs_k[:, None] * stride_bk + offs_bn[None, :] * stride_bn)

    # -----------------------------------------------------------
    # Iterate to compute a block of the C matrix.
    # We accumulate into a `[BLOCK_SIZE_M, BLOCK_SIZE_N]` block
    # of fp32 values for higher accuracy.
    # `accumulator` will be converted back to fp16 after the loop.
    accumulator = tl.zeros((BLOCK_SIZE_M, BLOCK_SIZE_N), dtype=tl.float32)
    for k in range(0, tl.cdiv(K, BLOCK_SIZE_K)):
        # Load the next block of A and B, generate a mask by checking the K dimension.
        # If it is out of bounds, set it to 0.
        a = tl.load(a_ptrs, mask=offs_k[None, :] < K - k * BLOCK_SIZE_K, other=0.0)
        b = tl.load(b_ptrs, mask=offs_k[:, None] < K - k * BLOCK_SIZE_K, other=0.0)
        # We accumulate along the K dimension.
        accumulator += tl.dot(a, b)
        # Advance the ptrs to the next K block.
        a_ptrs += BLOCK_SIZE_K * stride_ak
        b_ptrs += BLOCK_SIZE_K * stride_bk
    c = accumulator.to(tl.float32)

    # -----------------------------------------------------------
    # Write back the block of the output matrix C with masks.
    offs_cm = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    offs_cn = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)
    c_ptrs = c_ptr + stride_cm * offs_cm[:, None] + stride_cn * offs_cn[None, :]
    c_mask = (offs_cm[:, None] < M) & (offs_cn[None, :] < N)
    tl.store(c_ptrs, c, mask=c_mask)


def benchmark_triton(shape, a_np, b_np, parallel=True):
    fn = triton_matmul_kernel
    fn_jit = triton.jit(fn)
    fn_jit_tuned = triton.runtime.Autotuner(fn_jit, fn_jit.arg_names, 
        reset_to_zero=None, 
        restore_value=None,
        configs=get_matmul_kernel_autotune_config(0 if parallel else 1),
        key=[],
    )

    M, N, K = shape
    a = torch.tensor(a_np, dtype=torch.float32, device="cpu").contiguous()
    b = torch.tensor(b_np, dtype=torch.float32, device="cpu").contiguous()
    c = torch.empty((M, N), dtype=torch.float32, device="cpu")
    assert a.shape[1] == b.shape[0], "Incompatible matrix dimensions"

    # 1D launch kernel where each block gets its own program.
    grid = lambda META: (
        triton.cdiv(M, META["BLOCK_SIZE_M"]) * triton.cdiv(N, META["BLOCK_SIZE_N"]),
    )

    torch.set_num_threads(multiprocessing.cpu_count())

    def run_triton_kernel():
        fn_jit_tuned[grid](
            a, b, c, M, N, K,
            a.stride(0), a.stride(1),
            b.stride(0), b.stride(1),
            c.stride(0), c.stride(1)
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
    return np.mean(times), c.numpy(), tuning_time


def benchmark_triton_single(shape, a_np, b_np):
    return benchmark_triton(shape, a_np, b_np, parallel=False)


if __name__ == "__main__":
    M = N = K = 512
    a_np = np.random.rand(M, K).astype(np.float32)
    b_np = np.random.rand(K, N).astype(np.float32)
    shape = (M, N, K)
    time_triton, result_triton, tuning_time = benchmark_triton(shape, a_np, b_np)
    time_triton_single, result_triton_single, tuning_time_single = benchmark_triton_single(shape, a_np, b_np)
    assert np.allclose(result_triton, result_triton_single, atol=1e-3, rtol=1e-3), f"triton result mismatch!"
    print(result_triton)
    print(result_triton_single)
    print(f"triton: {time_triton} Tuning Time:{tuning_time}") 
    print(f"triton_single: {time_triton_single} Tuning Time:{tuning_time_single}")
