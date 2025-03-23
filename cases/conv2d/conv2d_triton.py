# ref: https://github.com/FlagOpen/FlagGems/blob/master/src/flag_gems/ops/conv2d.py

import torch
import numpy as np
import triton
import triton.language as tl
import os

from config import measurement_iterations, warmup_iterations

from BenchmarkConv2d import BenchmarkConv2d

def get_configs():
    configs = []
    for BLOCK_NI_HO_WO in [32, 64, 128]:
        for BLOCK_CI in [16, 32]:
            for BLOCK_CO in [16, 32, 64]:
                configs.append(triton.Config({
                    'BLOCK_NI_HO_WO': BLOCK_NI_HO_WO,
                    'BLOCK_CI': BLOCK_CI,
                    'BLOCK_CO': BLOCK_CO,
                }))
    return configs

def conv2d_output_size(
    in_size: int,
    kernel_size: int,
    stride: int,
    padding: int,
    dilation: int,
) -> int:
    """
    Determines the output size of a 2D convolution operation.

    Args:
        in_size: Input size.
        kernel_size: Kernel size.
        stride: Stride.
        padding: Padding.
        dilation: Dilation.

    Returns:
        Output size of 2D convolution.
    """
    return (in_size + 2 * padding - dilation * (kernel_size - 1) - 1) // stride + 1

@triton.autotune(
    configs=get_configs(),
    key=[
        "in_n",
        "weight_c",
        "input_height",
        "input_width",
        "out_c",
        "out_height",
        "out_width",
        "weight_height",
        "weight_width",
        "stride_height",
        "stride_width",
        "padding_height",
        "padding_width",
        "groups",
    ],
)
@triton.jit
def conv2d_kernel(
    input_pointer, weight_pointer, output_pointer, bias_pointer,
    in_n, input_height, input_width,
    out_c, out_height, out_width,
    input_n_stride, input_c_stride, input_height_stride, input_width_stride,
    weight_n_stride, weight_c_stride, weight_height_stride, weight_width_stride,
    output_n_stride, output_c_stride, output_height_stride, output_width_stride,
    weight_c: tl.constexpr, weight_height: tl.constexpr, weight_width: tl.constexpr,
    stride_height: tl.constexpr, stride_width: tl.constexpr,
    padding_height: tl.constexpr, padding_width: tl.constexpr,
    dilation_height: tl.constexpr, dilation_width: tl.constexpr,
    groups: tl.constexpr,
    BLOCK_NI_HO_WO: tl.constexpr, BLOCK_CI: tl.constexpr, BLOCK_CO: tl.constexpr,
):
    # Program IDs for the 3D grid
    pid_ni_ho_wo = tl.program_id(0)  # Batch * output height * output width
    pid_co = tl.program_id(1)  # Output channels
    pid_group = tl.program_id(2)  # Group
    
    # Calculate batch, height, width indices
    ni_ho_wo_offset = pid_ni_ho_wo * BLOCK_NI_HO_WO + tl.arange(0, BLOCK_NI_HO_WO)
    ni_ho_offset = ni_ho_wo_offset // out_width
    in_n_point_value = ni_ho_offset // out_height
    output_height_point_value = ni_ho_offset % out_height
    output_width_point_value = ni_ho_wo_offset % out_width
    
    # Calculate channel offsets based on groups
    out_per_group_c = out_c // groups
    output_c_offset = pid_co * BLOCK_CO + tl.arange(0, BLOCK_CO)
    
    # Adjust input and weight pointers for group
    input_pointer += (
        input_n_stride * in_n_point_value + input_c_stride * pid_group * weight_c
    )[:, None]
    
    weight_pointer += (
        weight_n_stride * output_c_offset
        + weight_n_stride * pid_group * out_per_group_c
    )[None, :]
    
    # Initialize accumulators
    accum = tl.zeros((BLOCK_NI_HO_WO, BLOCK_CO), dtype=tl.float32)
    
    # Compute how many channel blocks we need
    BLOCK_CI_COUNT = (weight_c + BLOCK_CI - 1) // BLOCK_CI
    
    # Loop over input channels and kernel dimensions
    for hwc in range(weight_height * weight_width * BLOCK_CI_COUNT):
        c = (hwc % BLOCK_CI_COUNT) * BLOCK_CI
        hw = hwc // BLOCK_CI_COUNT
        h = hw // weight_width
        w = hw % weight_width
        
        # Calculate offsets
        input_c_offset = c + tl.arange(0, BLOCK_CI)
        input_height_offset = (
            h * dilation_height
            - padding_height
            + stride_height * output_height_point_value
        )
        input_width_offset = (
            w * dilation_width 
            - padding_width 
            + stride_width * output_width_point_value
        )
        
        # Calculate current pointers
        curr_input_pointer = (
            input_pointer
            + (input_c_stride * input_c_offset)[None, :]
            + (input_height_stride * input_height_offset)[:, None]
            + (input_width_stride * input_width_offset)[:, None]
        )
        
        curr_weight_pointer = (
            weight_pointer
            + (weight_c_stride * input_c_offset)[:, None]
            + (weight_height_stride * h)
            + (weight_width_stride * w)
        )
        
        # Create masks for valid elements
        input_mask = (
            (in_n_point_value < in_n)[:, None]
            & (input_c_offset < weight_c)[None, :]
            & (0 <= input_height_offset)[:, None]
            & (input_height_offset < input_height)[:, None]
            & (0 <= input_width_offset)[:, None]
            & (input_width_offset < input_width)[:, None]
        )
        
        weight_mask = (input_c_offset < weight_c)[:, None] & (
            output_c_offset < out_per_group_c
        )[None, :]
        
        # Load input and weight values
        input_block = tl.load(curr_input_pointer, mask=input_mask, other=0.0)
        weight_block = tl.load(curr_weight_pointer, mask=weight_mask, other=0.0)
        
        # Compute matrix multiplication
        accum += tl.dot(input_block, weight_block)
    
    # Add bias if available
    if bias_pointer is not None:
        bias_ptr = bias_pointer + (pid_group * out_per_group_c + output_c_offset)[None, :]
        mask_bias = (output_c_offset < out_per_group_c)[None, :]
        bias = tl.load(bias_ptr, mask=mask_bias, other=0.0).to(tl.float32)
        accum += bias
    
    # Calculate output pointers
    output_pointer += (
        (output_n_stride * in_n_point_value)[:, None]
        + (output_c_stride * (pid_group * out_per_group_c + output_c_offset))[None, :]
        + (output_height_stride * output_height_point_value)[:, None]
        + (output_width_stride * output_width_point_value)[:, None]
    )
    
    # Create mask for valid output elements
    output_mask = (
        (in_n_point_value < in_n)[:, None]
        & (output_c_offset < out_per_group_c)[None, :]
        & (output_height_point_value < out_height)[:, None]
        & (output_width_point_value < out_width)[:, None]
    )
    
    # Store the results
    tl.store(output_pointer, accum, mask=output_mask)

class BenchmarkConv2dTriton(BenchmarkConv2d):

    def __init__(self):
        super().__init__('triton', True)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        os.environ["TRITON_CPU_BACKEND"] = "1"
        os.environ["TRITON_CPU_MAX_THREADS"] = "0" if self.parallel else "1"

        self.input = torch.tensor(x_np, device='cpu', dtype=torch.float32)
        self.weight = torch.tensor(w_np, device='cpu', dtype=torch.float32)
        self.bias = torch.tensor(b_np, device='cpu', dtype=torch.float32) if b_np is not None else None
        self.groups = groups

        self.stride = (stride, stride) if isinstance(stride, int) else stride
        self.padding = (padding, padding) if isinstance(padding, int) else padding
        self.dilation = (dilation, dilation) if isinstance(dilation, int) else dilation

        assert self.input.shape[1] % self.groups == 0, "in_channels must be divisible by groups"
        assert self.weight.shape[0] % self.groups == 0, "out_channels must be divisible by groups"
        assert self.input.shape[1] // self.groups == self.weight.shape[1], "Invalid filter dimensions for groups"

    def process(self):
        batch_size, in_channels, in_height, in_width = self.input.shape
        out_channels, in_channels_per_group, kernel_height, kernel_width = self.weight.shape

        stride_h, stride_w = self.stride
        padding_h, padding_w = self.padding
        dilation_h, dilation_w = self.dilation

        out_height = conv2d_output_size(in_height, kernel_height, stride_h, padding_h, dilation_h)
        out_width = conv2d_output_size(in_width, kernel_width, stride_w, padding_w, dilation_w)

        output = torch.zeros((batch_size, out_channels, out_height, out_width), 
                            dtype=self.input.dtype, device=self.input.device)

        # Create grid dimensions: (batch*height*width blocks, output channel blocks, groups)
        grid = lambda META: (
            triton.cdiv(batch_size * out_height * out_width, META["BLOCK_NI_HO_WO"]),
            triton.cdiv(out_channels // self.groups, META["BLOCK_CO"]),
            self.groups,
        )

        # Launch the kernel
        conv2d_kernel[grid](
            self.input,
            self.weight,
            output,
            self.bias,
            batch_size,
            in_height,
            in_width,
            out_channels,
            out_height,
            out_width,
            self.input.stride(0), self.input.stride(1), self.input.stride(2), self.input.stride(3),
            self.weight.stride(0), self.weight.stride(1), self.weight.stride(2), self.weight.stride(3),
            output.stride(0), output.stride(1), output.stride(2), output.stride(3),
            in_channels_per_group,
            kernel_height,
            kernel_width,
            stride_h,
            stride_w,
            padding_h,
            padding_w,
            dilation_h,
            dilation_w,
            self.groups,
        )
        
        return output


if __name__ == "__main__":
    # Test the convolution with a simple example
    batch_size, in_channels, in_height, in_width = 1, 3, 32, 32
    out_channels, kernel_height, kernel_width = 16, 3, 3
    
    x_np = np.random.rand(batch_size, in_channels, in_height, in_width).astype(np.float32)
    w_np = np.random.rand(out_channels, in_channels, kernel_height, kernel_width).astype(np.float32)
    b_np = np.random.rand(out_channels).astype(np.float32)
    
    # Test without bias
    benchmark = BenchmarkConv2dTriton()
    time_triton, result_triton, warmup_times= benchmark.benchmark(x_np, w_np, b_np, False)
    time_triton_parallel, result_triton_parallel, warpup_times_parallel = benchmark.benchmark(x_np, w_np, b_np, True)
    
    # Verify with PyTorch
    x_torch = torch.tensor(x_np, dtype=torch.float32)
    w_torch = torch.tensor(w_np, dtype=torch.float32)
    b_torch = torch.tensor(b_np, dtype=torch.float32)
    expected = torch.nn.functional.conv2d(x_torch, w_torch, b_torch).numpy()
    
    assert np.allclose(result_triton, expected, atol=1e-3, rtol=1e-3), "Triton result mismatch!"
    assert np.allclose(result_triton_parallel, expected, atol=1e-3, rtol=1e-3), "Triton parallel result mismatch!"
    
    print(f"Triton single: {time_triton} ms (tuning: {warmup_times} ms)")
    print(f"Triton parallel: {time_triton_parallel} ms (tuning: {warpup_times_parallel} ms)")

