import torch

import triton
import triton.language as tl
triton.runtime.driver.set_active_to_cpu()

import os

USE_GPU = False

def get_matmul_kernel_autotune_config():
    configs=[]
    for BLOCK_SIZE_M in [4, 8, 16, 32]:
        for BLOCK_SIZE_N in [4, 8, 16, 32]:
            for BLOCK_SIZE_K in [4, 8, 16, 32]:
                configs.append(triton.Config({'BLOCK_SIZE_M': BLOCK_SIZE_M, 'BLOCK_SIZE_N': BLOCK_SIZE_N, 'BLOCK_SIZE_K': BLOCK_SIZE_K}))
    # for BLOCK_SIZE_M in [4, 8, 16, 32, 64, 128]:
    #     for BLOCK_SIZE_N in [4, 8, 16, 32, 64, 128]:
    #         for BLOCK_SIZE_K in [4, 8, 16, 32, 64, 128]:
    #             configs.append(triton.Config({'BLOCK_SIZE_M': BLOCK_SIZE_M, 'BLOCK_SIZE_N': BLOCK_SIZE_N, 'BLOCK_SIZE_K': BLOCK_SIZE_K}))
    # for BLOCK_SIZE_M in [4, 8, 16, 32, 64]:
    #     BLOCK_SIZE_N = BLOCK_SIZE_M
    #     for BLOCK_SIZE_K in [8, 16, 32, 64, 128]:
    #         configs.append(triton.Config({'BLOCK_SIZE_M': BLOCK_SIZE_M, 'BLOCK_SIZE_N': BLOCK_SIZE_N, 'BLOCK_SIZE_K': BLOCK_SIZE_K}))

    if(os.getenv("ENABLE_AUTOTUNING") == "matmul_kernel"):
      assert (len(configs) > 1), "Autotuning config size need be larger than 1"
      return configs

    return [triton.Config({'BLOCK_SIZE_M': 64, 'BLOCK_SIZE_N': 8, 'BLOCK_SIZE_K': 16})]

@triton.autotune(
    configs=get_matmul_kernel_autotune_config(),
    key=[],
)
@triton.jit
def matmul_kernel(
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
        BLOCK_SIZE_M: tl.constexpr, BLOCK_SIZE_N: tl.constexpr, BLOCK_SIZE_K: tl.constexpr,  #
        ACTIVATION: tl.constexpr  #
):
    # Map program ids `pid` to the block of C it should compute.
    pid = tl.program_id(axis=0)
    num_pid_n = tl.cdiv(N, BLOCK_SIZE_N)
    pid_m = pid // num_pid_n
    pid_n = pid % num_pid_n

    # `a_ptrs` is a block of [BLOCK_SIZE_M, BLOCK_SIZE_K] pointers
    # `b_ptrs` is a block of [BLOCK_SIZE_K, BLOCK_SIZE_N] pointers
    offs_am = (pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)) % M
    offs_bn = (pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)) % N
    offs_k = tl.arange(0, BLOCK_SIZE_K)
    a_ptrs = a_ptr + (offs_am[:, None] * stride_am + offs_k[None, :] * stride_ak)
    b_ptrs = b_ptr + (offs_k[:, None] * stride_bk + offs_bn[None, :] * stride_bn)

    # Iterate to compute a block of the C matrix.
    accumulator = tl.zeros((BLOCK_SIZE_M, BLOCK_SIZE_N), dtype=tl.float32)
    for k in range(0, tl.cdiv(K, BLOCK_SIZE_K)):
        a = tl.load(a_ptrs, mask=offs_k[None, :] < K - k * BLOCK_SIZE_K, other=0.0)
        b = tl.load(b_ptrs, mask=offs_k[:, None] < K - k * BLOCK_SIZE_K, other=0.0)
        # We accumulate along the K dimension.
        accumulator += tl.dot(a, b)
        # Advance the ptrs to the next K block.
        a_ptrs += BLOCK_SIZE_K * stride_ak
        b_ptrs += BLOCK_SIZE_K * stride_bk

    c = accumulator.to(tl.float32)

    offs_cm = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    offs_cn = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)
    c_ptrs = c_ptr + stride_cm * offs_cm[:, None] + stride_cn * offs_cn[None, :]
    c_mask = (offs_cm[:, None] < M) & (offs_cn[None, :] < N)
    tl.store(c_ptrs, c, mask=c_mask)



# We can fuse `leaky_relu` by providing it as an `ACTIVATION` meta-parameter in `_matmul`.
@triton.jit
def leaky_relu(x):
    x = x + 1
    return tl.where(x >= 0, x, 0.01 * x)


def matmul(a, b, activation=""):
    # Check constraints.
    assert a.shape[1] == b.shape[0], "Incompatible dimensions"
    assert a.is_contiguous(), "Matrix A must be contiguous"
    assert b.is_contiguous(), "Matrix B must be contiguous"
    M, K = a.shape
    K, N = b.shape
    # Allocates output.
    c = torch.empty((M, N), device=a.device, dtype=a.dtype)
    # 1D launch kernel where each block gets its own program.
    grid = lambda META: (triton.cdiv(M, META['BLOCK_SIZE_M']) * triton.cdiv(N, META['BLOCK_SIZE_N']), )
    matmul_kernel[grid](
        a, b, c,  #
        M, N, K,  #
        a.stride(0), a.stride(1),  #
        b.stride(0), b.stride(1),  #
        c.stride(0), c.stride(1),  #
        ACTIVATION=activation,  #
    )
    return c


def test_matmul():
    torch.manual_seed(0)
    rows1 = 179
    cols1 = 167
    rows2 = 167
    cols2 = 321
    a = torch.randn((rows1, cols1), device='cpu', dtype=torch.float32)
    b = torch.randn((rows2, cols2), device='cpu', dtype=torch.float32)
    # a = torch.full((rows1, cols1), 1, device='cpu', dtype=torch.float32)
    # b = torch.full((rows2, cols2), 1, device='cpu', dtype=torch.float32)
    triton_output = matmul(a, b)
    torch_output = torch.matmul(a, b)
    '''
    print(f"triton_output={triton_output}")
    print(f"torch_output={torch_output}")
    if torch.allclose(triton_output, torch_output, atol=1e-2, rtol=0):
        print("✅ Triton and Torch match")
    else:
        print("❌ Triton and Torch differ")
    '''

test_matmul()
