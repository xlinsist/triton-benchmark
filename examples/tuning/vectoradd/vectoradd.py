import torch

import triton
import triton.language as tl

DEFAULT_BLOCK_SIZE = 1024
DEFAULT_TILE_SIZE = 16


@triton.autotune(
    configs=[
        triton.Config({'BLOCK_SIZE': 64}, num_threads=1),
        triton.Config({'BLOCK_SIZE': 256}, num_threads=1),
        triton.Config({'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'BLOCK_SIZE': 4096}, num_threads=1),
        triton.Config({'BLOCK_SIZE': 16384}, num_threads=1),
    ],
    key=['n_elements'],
)
@triton.jit
def add_kernel(x_ptr,  # *Pointer* to first input vector.
               y_ptr,  # *Pointer* to second input vector.
               output_ptr,  # *Pointer* to output vector.
               n_elements,  # Size of the vector.
               BLOCK_SIZE: tl.constexpr,  # Number of elements each program should process.
               # NOTE: `constexpr` so it can be used as a shape value.
               ):
    pid = tl.program_id(axis=0)  # We use a 1D launch grid so axis is 0.
    block_start = pid * BLOCK_SIZE
    offsets = block_start + tl.arange(0, BLOCK_SIZE)
    mask = offsets < n_elements
    x = tl.load(x_ptr + offsets, mask=mask)
    y = tl.load(y_ptr + offsets, mask=mask)
    output = x + y
    tl.store(output_ptr + offsets, output, mask=mask)


@triton.autotune(
    configs=[
        triton.Config({'TILE_SIZE': 4, 'BLOCK_SIZE': 64}, num_threads=1),
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 64}, num_threads=1),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 64}, num_threads=1),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 64}, num_threads=1),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 64}, num_threads=1),
        triton.Config({'TILE_SIZE': 4, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 1024}, num_threads=1),
        triton.Config({'TILE_SIZE': 4, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 16384}, num_threads=1),
    ],
    key=['n_elements'],
)
@triton.jit
def add_kernel_tiled(x_ptr,  # *Pointer* to first input vector.
                     y_ptr,  # *Pointer* to second input vector.
                     output_ptr,  # *Pointer* to output vector.
                     n_elements,  # Size of the vector.
                     BLOCK_SIZE: tl.constexpr,  # Number of elements each program should process.
                     TILE_SIZE: tl.constexpr,  # Number of elements each iteration should process.
                     ):
    pid = tl.program_id(axis=0)
    block_start = pid * BLOCK_SIZE
    for i in range(0, tl.cdiv(BLOCK_SIZE, TILE_SIZE)):
        offsets = block_start + i * TILE_SIZE + tl.arange(0, TILE_SIZE)
        mask = offsets < n_elements
        x = tl.load(x_ptr + offsets, mask=mask)
        y = tl.load(y_ptr + offsets, mask=mask)
        output = x + y
        tl.store(output_ptr + offsets, output, mask=mask)


@triton.autotune(
    configs=[
        triton.Config({'TILE_SIZE': 4, 'BLOCK_SIZE': 64}, num_threads=0),
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 64}, num_threads=0),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 64}, num_threads=0),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 64}, num_threads=0),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 64}, num_threads=0),
        triton.Config({'TILE_SIZE': 4, 'BLOCK_SIZE': 1024}, num_threads=0),
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 1024}, num_threads=0),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 1024}, num_threads=0),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 1024}, num_threads=0),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 1024}, num_threads=0),
        triton.Config({'TILE_SIZE': 4, 'BLOCK_SIZE': 16384}, num_threads=0),
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 16384}, num_threads=0),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 16384}, num_threads=0),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 16384}, num_threads=0),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 16384}, num_threads=0),
    ],
    key=['n_elements'],
)
@triton.jit
def add_kernel_tiled_autotuned(x_ptr,  # *Pointer* to first input vector.
                               y_ptr,  # *Pointer* to second input vector.
                               output_ptr,  # *Pointer* to output vector.
                               n_elements,  # Size of the vector.
                               BLOCK_SIZE: tl.constexpr,  # Number of elements each program should process.
                               TILE_SIZE: tl.constexpr,  # Number of elements each iteration should process.
                               ):
    pid = tl.program_id(axis=0)
    block_start = pid * BLOCK_SIZE
    for i in range(0, tl.cdiv(BLOCK_SIZE, TILE_SIZE)):
        offsets = block_start + i * TILE_SIZE + tl.arange(0, TILE_SIZE)
        mask = offsets < n_elements
        x = tl.load(x_ptr + offsets, mask=mask)
        y = tl.load(y_ptr + offsets, mask=mask)
        output = x + y
        tl.store(output_ptr + offsets, output, mask=mask)


def add(x: torch.Tensor, y: torch.Tensor, output: torch.Tensor, device):
    if output is None:
        output = torch.empty_like(x)
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    # add_kernel[grid](x, y, output, n_elements, BLOCK_SIZE=DEFAULT_BLOCK_SIZE)
    add_kernel[grid](x, y, output, n_elements)
    return output


def add_tiled(x: torch.Tensor, y: torch.Tensor, output):
    if output is None:
        output = torch.empty_like(x)
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    # add_kernel_tiled[grid](x, y, output, n_elements, BLOCK_SIZE=DEFAULT_BLOCK_SIZE, TILE_SIZE=DEFAULT_TILE_SIZE)
    add_kernel_tiled[grid](x, y, output, n_elements)
    return output


def add_tiled_autotuned(x: torch.Tensor, y: torch.Tensor, output):
    if output is None:
        output = torch.empty_like(x)
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    add_kernel_tiled_autotuned[grid](x, y, output, n_elements)
    return output


# %%
# We can now use the above function to compute the element-wise sum of two `torch.tensor` objects and test its correctness:
torch.manual_seed(0)
size = 98432

triton.runtime.driver.set_active_to_cpu()
x = torch.rand(size, device='cpu')
y = torch.rand(size, device='cpu')
output_torch_cpu = torch.add(x, y)
output_triton_cpu = add(x, y, None, device='cpu')
print(output_torch_cpu)
print(output_triton_cpu)
print(f'The maximum difference between torch-cpu and triton-cpu is '
      f'{torch.max(torch.abs(output_torch_cpu - output_triton_cpu))}')
output_triton_cpu = add_tiled(x, y, None)
print(f'The maximum difference between torch-cpu and triton-cpu-tiled is '
      f'{torch.max(torch.abs(output_torch_cpu - output_triton_cpu))}')

LINE_VALS = [
    'triton-cpu', 'triton-cpu-tiled', 'triton-cpu-tiled-autotuned', 'torch-cpu'
]
LINE_NAMES = [
    'TritonCPU', 'TritonCPUTiled', 'TritonCPUTiled (autotuned)', 'TorchCPU'
]
LINE_STYLES = [('blue', '-'), ('red', '-'), ('orange', '-'), ('green', '-')]


# %%
# Benchmark
@triton.testing.perf_report(
    triton.testing.Benchmark(
        x_names=['size'],  # Argument names to use as an x-axis for the plot.
        x_vals=[2**i for i in range(12, 28, 1)],  # Different possible values for `x_name`.
        x_log=True,  # x axis is logarithmic.
        line_arg='provider',  # Argument name whose value corresponds to a different line in the plot.
        line_vals=LINE_VALS,  # Possible values for `line_arg`.
        line_names=LINE_NAMES,  # Label name for the lines.
        styles=LINE_STYLES,  # Line styles.
        ylabel='GB/s',  # Label name for the y-axis.
        plot_name=
        # Name for the plot. Used also as a file name for saving the plot.
        f'vector-add-performance (BLOCK_SIZE={DEFAULT_BLOCK_SIZE})',
        args={},  # Values for function arguments not in `x_names` and `y_name`.
    ))
def benchmark(size, provider):

    device = 'cpu'
    x = torch.rand(size, device=device, dtype=torch.float32)
    y = torch.rand(size, device=device, dtype=torch.float32)

    triton.runtime.driver.set_active_to_cpu()
    output = torch.empty_like(x)

    quantiles = [0.5, 0.2, 0.8]
    if provider == 'torch-cpu':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: torch.add(x, y, out=output), quantiles=quantiles)
    elif provider == 'triton-cpu':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: add(x, y, output, device), quantiles=quantiles,
                                                     measure_time_with_hooks=True)
    elif provider == 'triton-cpu-tiled':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: add_tiled(x, y, output), quantiles=quantiles,
                                                     measure_time_with_hooks=True)
    elif provider == 'triton-cpu-tiled-autotuned':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: add_tiled_autotuned(x, y, output), quantiles=quantiles,
                                                     measure_time_with_hooks=True)
    gbps = lambda ms: 3 * x.numel() * x.element_size() * 1e-9 / (ms * 1e-3)
    return gbps(ms), gbps(max_ms), gbps(min_ms)

benchmark.run(print_data=True, show_plots=True, save_path=".")
