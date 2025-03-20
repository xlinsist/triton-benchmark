import torch
import numpy as np
import triton
import triton.language as tl
import os

from BenchmarkTranspose import BenchmarkTranspose

def get_configs():
    configs = []
    for BLOCK_SIZE_M in [16, 32, 64]:
        for BLOCK_SIZE_N in [16, 32, 64]:
            configs.append(triton.Config({'BLOCK_SIZE_M': BLOCK_SIZE_M, 'BLOCK_SIZE_N': BLOCK_SIZE_N}))
    return configs

# Enable full autotuning for benchmarking
@triton.autotune(get_configs(), key=['M', 'N'])
@triton.jit
def transpose_kernel(
    # Pointers to matrices
    input_ptr, output_ptr,
    # Matrix dimensions
    M, N,
    # The stride variables
    input_stride_m, input_stride_n,
    output_stride_m, output_stride_n,
    # Meta-parameters
    BLOCK_SIZE_M: tl.constexpr, BLOCK_SIZE_N: tl.constexpr
):
    """Optimized kernel for computing the transpose of a matrix.
    Input has shape (M, N), output has shape (N, M)
    """
    # Map program ids to the block of the output it should compute
    pid = tl.program_id(axis=0)
    num_pid_n = tl.cdiv(N, BLOCK_SIZE_N)
    pid_m = pid // num_pid_n
    pid_n = pid % num_pid_n

    # Create offsets for the blocks
    offs_m = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    offs_n = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)
    
    # Create input and output pointers for the entire block
    input_ptrs = input_ptr + offs_m[:, None] * input_stride_m + offs_n[None, :] * input_stride_n
    
    # Create masks to handle boundary conditions
    mask = (offs_m[:, None] < M) & (offs_n[None, :] < N)
    
    # Load the block from input
    block = tl.load(input_ptrs, mask=mask)
    
    # Transpose the block in SRAM
    block_t = tl.trans(block)
    
    # Store the transposed block to output
    # Note: we need to swap m and n for the output
    output_ptrs = output_ptr + offs_n[:, None] * output_stride_m + offs_m[None, :] * output_stride_n
    # We need to transpose the mask as well
    mask_t = tl.trans(mask)
    tl.store(output_ptrs, block_t, mask=mask_t)

def transpose(x, y=None):
    """Compute the transpose of a matrix using Triton.
    
    Args:
        x: Input matrix(tensor or ndarray or...) of shape (M, N)
        y: Optional output tensor of shape (N, M)
        
    Returns:
        Transposed tensor of shape (N, M)
    """
    M, N = x.shape
    
    # Allocate output if not provided
    if not isinstance(x, torch.Tensor):
        x = torch.tensor(x, device='cpu', dtype=torch.float32)
    if y is None:
        y = torch.empty((N, M), dtype=x.dtype, device=x.device)
    
    # Launch the kernel with a 2D grid where each block gets its own program
    grid = lambda META: (triton.cdiv(M, META['BLOCK_SIZE_M']) * triton.cdiv(N, META['BLOCK_SIZE_N']), )
    
    transpose_kernel[grid](
        x, y,
        M, N,
        x.stride(0), x.stride(1),
        y.stride(0), y.stride(1),
        )
    
    return y

class BenchmarkTriton(BenchmarkTranspose):

    def __init__(self):
        super().__init__('triton', True)

    def preprocess(self, x_np):
        os.environ["TRITON_CPU_BACKEND"] = "1"
        os.environ["TRITON_CPU_MAX_THREADS"] = "0" if self.parallel else "1"
        return torch.tensor(x_np, device='cpu', dtype=torch.float32)

    def process(self, x):
        return transpose(x)

if __name__ == "__main__":
    M, N = 1024, 768
    x_np = np.random.rand(M, N).astype(np.float32)
    benchmarkTriton = BenchmarkTriton()
    expect = x_np.transpose()
    
    time_triton, result_triton, warmup_times = benchmarkTriton.benchmark(x_np)
    time_triton_parallel, result_triton_parallel, warpup_times_parallel = benchmarkTriton.benchmark(x_np, True)
    
    # Verify correctness
    assert np.allclose(result_triton, expect, atol=1e-3, rtol=1e-3), "Triton result mismatch!"
    assert np.allclose(result_triton_parallel, expect, atol=1e-3, rtol=1e-3), "Triton parallel result mismatch!"
    
    print(f"Triton single: {time_triton} ms (tuning: {warmup_times} ms)")
    print(f"Triton parallel: {time_triton_parallel} ms (tuning: {warmup_times} ms)")

