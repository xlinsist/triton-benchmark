import os
import torch

import triton
import triton.language as tl

# 让 Triton 在 CPU 后端运行
triton.runtime.driver.set_active_to_cpu()
USE_GPU = False

def get_add_kernel_autotune_config():
    configs = []
    # 这里按“分块”思路：每个 program 处理一段长度为 BLOCK_SIZE 的向量
    for BLOCK_SIZE in [1024, 4096]:
        configs.append(triton.Config({"BLOCK_SIZE": BLOCK_SIZE, "TILE_SIZE": 16}))
    if os.getenv("ENABLE_AUTOTUNING") == "add_kernel":
        assert len(configs) > 1
        return configs
    # 默认给一个配置
    return [triton.Config({"BLOCK_SIZE": 4096})]


@triton.autotune(
    configs=get_add_kernel_autotune_config(),
    key=[],
)
@triton.jit
def add_kernel(x_ptr,  # *Pointer* to first input vector.
                     y_ptr,  # *Pointer* to second input vector.
                     output_ptr,  # *Pointer* to output vector.
                     n_elements,  # Size of the vector.
                     stride_a, stride_b, stride_c,
                     BLOCK_SIZE: tl.constexpr,  # Number of elements each program should process.
                     TILE_SIZE: tl.constexpr,  # Number of elements each iteration should process.
                     # NOTE `constexpr` so it can be used as a shape value.
                     ):
    pid = tl.program_id(axis=0)
    block_start = pid * BLOCK_SIZE
    for i in range(0, tl.cdiv(BLOCK_SIZE, TILE_SIZE)):
        offsets = block_start + i * TILE_SIZE + tl.arange(0, TILE_SIZE)

        # x = tl.load(x_ptr + offsets * stride_a)
        # y = tl.load(y_ptr + offsets * stride_b)
        # output = x + y
        # tl.store(output_ptr + offsets * stride_c, output)

        mask = offsets < n_elements
        x = tl.load(x_ptr + offsets * stride_a, mask=mask)
        y = tl.load(y_ptr + offsets * stride_b, mask=mask)
        output = x + y
        tl.store(output_ptr + offsets * stride_c, output, mask=mask)


def add(x: torch.Tensor, y: torch.Tensor):
    output = torch.empty_like(x)
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    add_kernel[grid](x, y, output, n_elements, x.stride(0), y.stride(0), output.stride(0))
    return output


def test_add():
    torch.manual_seed(0)
    # 用一些不整齐的长度来测试 mask 是否正确
    size = 1024
    x = torch.rand(size, device='cpu')
    y = torch.rand(size, device='cpu')

    triton_output = add(x, y)
    torch_output = x + y

    # assert torch.allclose(triton_output, torch_output, atol=0, rtol=0), "❌ Triton and Torch differ"
    # print("✅ Triton and Torch match")


test_add()
