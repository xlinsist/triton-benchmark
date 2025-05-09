"""
Fused Softmax
=============

In this tutorial, you will write a fused softmax operation that is significantly faster
than PyTorch's native op for a particular class of matrices: those whose rows can fit in
the GPU's SRAM.

In doing so, you will learn about:

* The benefits of kernel fusion for bandwidth-bound operations.

* Reduction operators in Triton.

"""

# %%
# Motivations
# -----------
#
# Custom GPU kernels for elementwise additions are educationally valuable but won't get you very far in practice.
# Let us consider instead the case of a simple (numerically stabilized) softmax operation:

import torch

import triton
import triton.language as tl

USE_GPU = False

import os

@torch.jit.script
def naive_softmax(x):
    """Compute row-wise softmax of X using native pytorch

    We subtract the maximum element in order to avoid overflows. Softmax is invariant to
    this shift.
    """
    # read  MN elements ; write M  elements
    x_max = x.max(dim=1)[0]
    # read MN + M elements ; write MN elements
    z = x - x_max[:, None]
    # read  MN elements ; write MN elements
    numerator = torch.exp(z)
    # read  MN elements ; write M  elements
    denominator = numerator.sum(dim=1)
    # read MN + M elements ; write MN elements
    ret = numerator / denominator[:, None]
    # in total: read 5MN + 2M elements ; wrote 3MN + 2M elements
    return ret


# %%
# When implemented naively in PyTorch, computing :code:`y = naive_softmax(x)` for :math:`x \in R^{M \times N}`
# requires reading :math:`5MN + 2M` elements from DRAM and writing back :math:`3MN + 2M` elements.
# This is obviously wasteful; we'd prefer to have a custom "fused" kernel that only reads
# X once and does all the necessary computations on-chip.
# Doing so would require reading and writing back only :math:`MN` bytes, so we could
# expect a theoretical speed-up of ~4x (i.e., :math:`(8MN + 4M) / 2MN`).
# The `torch.jit.script` flags aims to perform this kind of "kernel fusion" automatically
# but, as we will see later, it is still far from ideal.

# %%
# Compute Kernel
# --------------
#
# Our softmax kernel works as follows: each program loads a row of the input matrix X,
# normalizes it and writes back the result to the output Y.
#
# Note that one important limitation of Triton is that each block must have a
# power-of-two number of elements, so we need to internally "pad" each row and guard the
# memory operations properly if we want to handle any possible input shapes:

def get_softmax_kernel_autotune_config():
    configs = []
    for BLOCK_SIZE in [64, 256, 1024, 4096]:
      for TILE_SIZE in [4, 8, 16, 32, 64]:
        configs.append(triton.Config({'BLOCK_SIZE': BLOCK_SIZE, 'TILE_SIZE': TILE_SIZE}))
    if(os.getenv("ENABLE_AUTOTUNING") == "softmax_kernel"):
      assert (len(configs) > 1), "Autotuning config size need be larger than 1"
      return configs

    return [triton.Config({'BLOCK_SIZE': 1024, 'TILE_SIZE': 16})]

@triton.autotune(
    configs=get_softmax_kernel_autotune_config(),
    key=[],
)
@triton.jit
def softmax_kernel(output_ptr, input_ptr, input_row_stride, output_row_stride, 
                   n_cols, BLOCK_SIZE: tl.constexpr, TILE_SIZE: tl.constexpr):
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
            # numerator = tl.exp(row_minus_max)
            numerator = 1 + row_minus_max + (row_minus_max * row_minus_max) / 2
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
            # numerator = tl.exp(row_minus_max)
            numerator = 1 + row_minus_max + (row_minus_max * row_minus_max) / 2
            softmax_output = numerator / acc_sum  # 归一化
            tl.store(output_ptrs, softmax_output, mask=col_mask)


# %%
# We can create a helper function that enqueues the kernel and its (meta-)arguments for any given input tensor.


def softmax(x, y=None):
    n_rows, n_cols = x.shape

    BLOCK_SIZE = 1024
    TILE_SIZE = 16

    # Allocate output
    if y is None:
        y = torch.empty_like(x)
    # Enqueue kernel. The 1D launch grid is simple: we have one kernel instance per row of
    # the input matrix
    softmax_kernel[(n_rows, )](
        y,
        x,
        x.stride(0),
        y.stride(0),
        n_cols,
    )
    return y


# %%
# Unit Test
# ---------

# %%
# We make sure that we test our kernel on a matrix with an irregular number of rows and columns.
# This will allow us to verify that our padding mechanism works.

triton.runtime.driver.set_active_to_cpu()

torch.manual_seed(0)
x = torch.randn(1823, 781, device='cpu')
y_triton_cpu = softmax(x)
# print(y_triton_cpu)
