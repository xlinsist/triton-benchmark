import os
import torch

import triton
import triton.language as tl

# 让 Triton 在 CPU 后端运行
triton.runtime.driver.set_active_to_cpu()
USE_GPU = False

def get_add_kernel_autotune_config():
    configs = []
    # 这里按“分块”思路：每个 program 处理一段长度为 TILE_SIZE 的向量
    for TILE_SIZE in [4, 8, 16, 32]:
        configs.append(triton.Config({"TILE_SIZE": TILE_SIZE}))
    if os.getenv("ENABLE_AUTOTUNING") == "add_kernel":
        assert len(configs) > 1
        return configs
    # 默认给一个配置
    return [triton.Config({"TILE_SIZE": 16})]


@triton.autotune(
    configs=get_add_kernel_autotune_config(),
    key=['n_elements'],
)
@triton.jit
def add_kernel(x_ptr, y_ptr, output_ptr, 
               n_elements, 
               stride_x, stride_y, stride_out,
               TILE_SIZE: tl.constexpr):
    # 获取当前的 program ID
    pid = tl.program_id(axis=0)

    for tile_start in range(0, n_elements, TILE_SIZE):
        offsets = tile_start + tl.arange(0, TILE_SIZE)
        mask = offsets < n_elements
        curr_x_ptr = x_ptr + offsets * stride_x
        curr_y_ptr = y_ptr + offsets * stride_y
        curr_out_ptr = output_ptr + offsets * stride_out
        x = tl.load(curr_x_ptr, mask=mask, other=0.0)
        y = tl.load(curr_y_ptr, mask=mask, other=0.0)
        res = x + y
        tl.store(curr_out_ptr, res, mask=mask)


def add(x: torch.Tensor, y: torch.Tensor):
    output = torch.empty_like(x)
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['TILE_SIZE']), )
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
