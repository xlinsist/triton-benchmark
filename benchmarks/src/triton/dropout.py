import torch
import triton
import triton.language as tl

import os

USE_GPU = False
triton.runtime.driver.set_active_to_cpu()

def get_dropout_kernel_autotune_config():
    configs = []
    for BLOCK_SIZE in [64, 256, 1024, 4096]:
      for TILE_SIZE in [4, 8, 16, 32, 64]:
        configs.append(triton.Config({'BLOCK_SIZE': BLOCK_SIZE, 'TILE_SIZE': TILE_SIZE}))
    if(os.getenv("ENABLE_AUTOTUNING") == "dropout_kernel"):
      assert (len(configs) > 1), "Autotuning config size need be larger than 1"
      return configs
    # 64 is better than 32 in T8
    return [configs[0]]

@triton.autotune(
    configs=get_dropout_kernel_autotune_config(),
    key=[],
)
@triton.jit
def dropout_kernel(
    x_ptr,
    output_ptr,
    n_elements,
    p,
    seed,
    BLOCK_SIZE: tl.constexpr,
    TILE_SIZE: tl.constexpr,
):
    pid = tl.program_id(axis=0)
    block_start = pid * BLOCK_SIZE

    for i in range(0, tl.cdiv(BLOCK_SIZE, TILE_SIZE)):
        offsets = block_start + i * TILE_SIZE + tl.arange(0, TILE_SIZE)
        mask = offsets < n_elements
        x = tl.load(x_ptr + offsets, mask=mask)
        random = tl.rand(seed, offsets)
        x_keep = random > p
        output = tl.where(x_keep, x / (1 - p), 0.0)
        tl.store(output_ptr + offsets, output, mask=mask)


def seeded_dropout(x, p, seed):
    output = torch.empty_like(x)
    assert x.is_contiguous()
    n_elements = x.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    dropout_kernel[grid](x, output, n_elements, p, seed)
    return output


x = torch.randn(size=(50, ))
# Compare this to the baseline - dropout mask is never instantiated!
output = seeded_dropout(x, p=0.5, seed=123)
output2 = seeded_dropout(x, p=0.5, seed=123)
output3 = seeded_dropout(x, p=0.5, seed=512)
