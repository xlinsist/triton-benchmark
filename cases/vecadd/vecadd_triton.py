# Refer to: https://github.com/triton-lang/triton-cpu/blob/main/python/tutorials/01-vector-add.py

import torch

import triton
import triton.language as tl

DEFAULT_BLOCK_SIZE = 1024
DEFAULT_TILE_SIZE = 16


@triton.autotune(
    configs=[
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 16384}, num_threads=1),
        triton.Config({'TILE_SIZE': 128, 'BLOCK_SIZE': 16384}, num_threads=1),
    ],
    key=['n_elements'],
)
@triton.jit
def add_kernel_T1(x_ptr,  # *Pointer* to first input vector.
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
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 128}, num_threads=16),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 128}, num_threads=16),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 128}, num_threads=16),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 128}, num_threads=16),
        triton.Config({'TILE_SIZE': 128, 'BLOCK_SIZE': 128}, num_threads=16),
    ],
    key=['n_elements'],
)
@triton.jit
def add_kernel_T16(x_ptr,  # *Pointer* to first input vector.
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
        triton.Config({'TILE_SIZE': 8, 'BLOCK_SIZE': 256}, num_threads=8),
        triton.Config({'TILE_SIZE': 16, 'BLOCK_SIZE': 256}, num_threads=8),
        triton.Config({'TILE_SIZE': 32, 'BLOCK_SIZE': 256}, num_threads=8),
        triton.Config({'TILE_SIZE': 64, 'BLOCK_SIZE': 256}, num_threads=8),
        triton.Config({'TILE_SIZE': 128, 'BLOCK_SIZE': 256}, num_threads=8),
        # triton.Config({'TILE_SIZE': 256, 'BLOCK_SIZE': 256}, num_threads=8),
    ],
    key=['n_elements'],
)
@triton.jit
def add_kernel_T8(x_ptr,  # *Pointer* to first input vector.
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


def add_T1(x: torch.Tensor, y: torch.Tensor, output: torch.Tensor, device):
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    # add_kernel_T1[grid](x, y, output, n_elements, BLOCK_SIZE=DEFAULT_BLOCK_SIZE)
    add_kernel_T1[grid](x, y, output, n_elements)
    return output


def add_T16(x: torch.Tensor, y: torch.Tensor, output):
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    # add_kernel_T16[grid](x, y, output, n_elements, BLOCK_SIZE=DEFAULT_BLOCK_SIZE, TILE_SIZE=DEFAULT_TILE_SIZE)
    add_kernel_T16[grid](x, y, output, n_elements)
    return output


def add_T8(x: torch.Tensor, y: torch.Tensor, output):
    n_elements = output.numel()
    grid = lambda meta: (triton.cdiv(n_elements, meta['BLOCK_SIZE']), )
    add_kernel_T8[grid](x, y, output, n_elements)
    return output


# %%
# Unit Test
torch.manual_seed(0)
size = 131072

triton.runtime.driver.set_active_to_cpu()
x = torch.rand(size, device='cpu')
y = torch.rand(size, device='cpu')
output = torch.empty_like(x)
output_torch_cpu = torch.add(x, y)
output_triton_cpu = add_T1(x, y, output, device='cpu')
print(output_torch_cpu)
print(output_triton_cpu)
print(f'The maximum difference between torch-cpu and triton-cpu is '
      f'{torch.max(torch.abs(output_torch_cpu - output_triton_cpu))}')
output_triton_cpu = add_T16(x, y, output)
print(f'The maximum difference between torch-cpu and triton-cpu-tiled is '
      f'{torch.max(torch.abs(output_torch_cpu - output_triton_cpu))}')

LINE_VALS = [
    'triton-cpu-T1', 'triton-cpu-T16', 'triton-cpu-T8', 'torch-cpu'
]
LINE_NAMES = [
    'triton-cpu-T1', 'triton-cpu-T16', 'triton-cpu-T8', 'torch-cpu'
]
LINE_STYLES = [('blue', '-'), ('red', '-'), ('orange', '-'), ('green', '-')]


# %%
# Benchmark
@triton.testing.perf_report(
    triton.testing.Benchmark(
        x_names=['size'],  # Argument names to use as an x-axis for the plot.
        x_vals=[32 * i for i in range(2, 150, 4)],  # Different possible values for `x_name`.
        # x_vals=[2**i for i in range(6, 22, 1)],  # Different possible values for `x_name`.
        # x_vals=[2**i for i in range(12, 28, 1)],  # Different possible values for `x_name`.
        x_log=True,  # x axis is logarithmic.
        line_arg='provider',  # Argument name whose value corresponds to a different line in the plot.
        line_vals=LINE_VALS,  # Possible values for `line_arg`.
        line_names=LINE_NAMES,  # Label name for the lines.
        styles=LINE_STYLES,  # Line styles.
        ylabel='MB/s',  # Label name for the y-axis.
        plot_name=
        # Name for the plot. Used also as a file name for saving the plot.
        f'vector-add-performance-tuning',
        args={},  # Values for function arguments not in `x_names` and `y_name`.
    ))
def benchmark(size, provider):

    device = 'cpu'
    triton.runtime.driver.set_active_to_cpu()
    x = torch.rand(size, device=device, dtype=torch.float32)
    y = torch.rand(size, device=device, dtype=torch.float32)
    output = torch.empty_like(x)
    default_num_threads = torch.get_num_threads()
    torch.set_num_threads(default_num_threads)
    quantiles = [0.5, 0.2, 0.8]
    if provider == 'torch-cpu':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: torch.add(x, y, out=output), quantiles=quantiles)
    elif provider == 'triton-cpu-T1':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: add_T1(x, y, output, device), quantiles=quantiles,
                                                     measure_time_with_hooks=True)
    elif provider == 'triton-cpu-T16':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: add_T16(x, y, output), quantiles=quantiles,
                                                     measure_time_with_hooks=True)
    elif provider == 'triton-cpu-T8':
        ms, min_ms, max_ms = triton.testing.do_bench(lambda: add_T8(x, y, output), quantiles=quantiles,
                                                     measure_time_with_hooks=True)
    print(size, " ", provider, " ", ms, " ", min_ms, " ", max_ms)
    gbps = lambda ms: 3 * x.numel() * x.element_size() * 1e-6 / (ms * 1e-3)
    return gbps(ms), gbps(max_ms), gbps(min_ms)

benchmark.run(print_data=True, show_plots=True, save_path=".")
