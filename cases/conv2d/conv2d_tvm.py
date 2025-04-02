# TVM Benchmark
# Refer to: https://tvm.apache.org/docs/reference/api/python/topi.html#tvm.topi.nn.conv2d

import numpy as np
import torch
import tvm
from tvm import te, topi
from BenchmarkConv2d import BenchmarkConv2d


class BenchmarkConv2dTVM(BenchmarkConv2d):

    def __init__(self):
        super().__init__('tvm', True)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        self.input_shape = x_np.shape
        self.weight_shape = w_np.shape
        self.dtype = str(x_np.dtype)

        # Convert to TVM tensors
        self.input_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.weight_tvm = tvm.nd.array(w_np, device=tvm.cpu())
        self.bias_tvm = tvm.nd.array(b_np, device=tvm.cpu()) if b_np is not None else None

        # Handle parameter formats
        self.stride = (stride, stride) if isinstance(stride, int) else stride
        self.padding = (padding, padding) if isinstance(padding, int) else padding
        self.dilation = (dilation, dilation) if isinstance(dilation, int) else dilation
        self.groups = groups

        # Create placeholders for the computation
        batch_size, in_channels, in_height, in_width = x_np.shape
        out_channels, in_channels_per_group, kernel_height, kernel_width = w_np.shape

        # Create input and weight tensors
        A = te.placeholder((batch_size, in_channels, in_height, in_width), name='A', dtype=self.dtype)
        W = te.placeholder((out_channels, in_channels_per_group, kernel_height, kernel_width), name='W', dtype=self.dtype)

        # Define the convolution computation
        stride_h, stride_w = self.stride
        padding_h, padding_w = self.padding
        dilation_h, dilation_w = self.dilation

        # Compute output dimensions
        out_height = (in_height + 2 * padding_h - dilation_h * (kernel_height - 1) - 1) // stride_h + 1
        out_width = (in_width + 2 * padding_w - dilation_w * (kernel_width - 1) - 1) // stride_w + 1

        if groups == 1:
            # Standard convolution
            B = topi.nn.conv2d(A, W, strides=self.stride, padding=self.padding, dilation=self.dilation, out_dtype=self.dtype)
        else:
            # Split input and weights into `groups` and perform grouped convolution
            A_splits = te.compute((groups, batch_size, in_channels // groups, in_height, in_width), lambda g, n, c, h, w: A[n, g * (in_channels // groups) + c, h, w], name="A_splits")
            W_splits = te.compute((groups, out_channels // groups, in_channels // groups, kernel_height, kernel_width), lambda g, oc, ic, kh, kw: W[g * (out_channels // groups) + oc, ic, kh, kw], name="W_splits")

            B_splits = [topi.nn.conv2d(A_splits[g], W_splits[g], strides=self.stride, padding=self.padding, dilation=self.dilation, out_dtype=self.dtype) for g in range(groups)]

            B = topi.concatenate(B_splits, axis=1)  # Concatenate along the channel dimension

        # Add bias if provided
        if b_np is not None:
            bias = te.placeholder((out_channels,), name='bias', dtype=self.dtype)
            B = topi.add(B, topi.reshape(bias, (1, out_channels, 1, 1)))
            self.has_bias = True
        else:
            self.has_bias = False

        s = te.create_schedule(B.op)

        # Apply parallelization if needed
        if self.parallel:
            output_op = s[B].op
            if isinstance(output_op, tvm.te.ComputeOp):
                n, f, y, x = output_op.axis
                s[B].parallel(n)

        # Build the function
        if self.has_bias:
            self.func = tvm.build(s, [A, W, bias, B], target="llvm", name="conv2d")
            self.output_tvm = tvm.nd.empty((batch_size, out_channels, out_height, out_width), 
                                        dtype=self.dtype, device=tvm.cpu())
        else:
            self.func = tvm.build(s, [A, W, B], target="llvm", name="conv2d")
            self.output_tvm = tvm.nd.empty((batch_size, out_channels, out_height, out_width), 
                                        dtype=self.dtype, device=tvm.cpu())

    def process(self):
        # Execute the function
        if self.has_bias:
            self.func(self.input_tvm, self.weight_tvm, self.bias_tvm, self.output_tvm)
        else:
            self.func(self.input_tvm, self.weight_tvm, self.output_tvm)

        return self.output_tvm.numpy()


class BenchmarkConv2dTVMO1(BenchmarkConv2d):
    """Optimized TVM implementation with adaptive tiling and parallelism"""

    def __init__(self):
        super().__init__('tvm-o1', True)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        self.input_shape = x_np.shape
        self.weight_shape = w_np.shape
        self.dtype = str(x_np.dtype)

        self.input_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.weight_tvm = tvm.nd.array(w_np, device=tvm.cpu())
        self.bias_tvm = tvm.nd.array(b_np, device=tvm.cpu()) if b_np is not None else None

        self.stride = (stride, stride) if isinstance(stride, int) else stride
        self.padding = (padding, padding) if isinstance(padding, int) else padding
        self.dilation = (dilation, dilation) if isinstance(dilation, int) else dilation
        self.groups = groups

        batch_size, in_channels, in_height, in_width = x_np.shape
        out_channels, in_channels_per_group, kernel_height, kernel_width = w_np.shape

        A = te.placeholder((batch_size, in_channels, in_height, in_width), name='A', dtype=self.dtype)
        W = te.placeholder((out_channels, in_channels_per_group, kernel_height, kernel_width), name='W', dtype=self.dtype)

        stride_h, stride_w = self.stride
        padding_h, padding_w = self.padding
        dilation_h, dilation_w = self.dilation

        out_height = (in_height + 2 * padding_h - dilation_h * (kernel_height - 1) - 1) // stride_h + 1
        out_width = (in_width + 2 * padding_w - dilation_w * (kernel_width - 1) - 1) // stride_w + 1

        if groups == 1:
            # Standard convolution
            B = topi.nn.conv2d(A, W, strides=self.stride, padding=self.padding, dilation=self.dilation, out_dtype=self.dtype)
        else:
            # Split input and weights into `groups` and perform grouped convolution
            A_splits = te.compute((groups, batch_size, in_channels // groups, in_height, in_width), lambda g, n, c, h, w: A[n, g * (in_channels // groups) + c, h, w], name="A_splits")
            W_splits = te.compute((groups, out_channels // groups, in_channels // groups, kernel_height, kernel_width), lambda g, oc, ic, kh, kw: W[g * (out_channels // groups) + oc, ic, kh, kw], name="W_splits")

            B_splits = [topi.nn.conv2d(A_splits[g], W_splits[g], strides=self.stride, padding=self.padding, dilation=self.dilation, out_dtype=self.dtype) for g in range(groups)]

            B = topi.concatenate(B_splits, axis=1)  # Concatenate along the channel dimension

        # Add bias if provided
        if b_np is not None:
            bias = te.placeholder((out_channels,), name='bias', dtype=self.dtype)
            B = topi.add(B, topi.reshape(bias, (1, out_channels, 1, 1)))
            self.has_bias = True
        else:
            self.has_bias = False

        s = te.create_schedule(B.op)

        # Apply optimization strategies
        # Get the output axes
        n, f, y, x = s[B].op.axis

        # Adapt tile sizes based on input dimensions
        # For larger inputs, use larger tiles to reduce overhead
        if out_width >= 56:
            tile_size_n = min(batch_size, 2)  # Adapt to batch size
            tile_size_f = min(32, out_channels // 2)  # Adapt to output channels
            tile_size_y = min(8, out_height // 4)
            tile_size_x = min(32, out_width // 4)
        else:
            tile_size_n = 1
            tile_size_f = min(16, out_channels // 2)
            tile_size_y = min(4, out_height // 2)
            tile_size_x = min(16, out_width // 2)

        # Apply tiling to the axes
        no, ni = s[B].split(n, factor=tile_size_n)
        fo, fi = s[B].split(f, factor=tile_size_f)
        yo, yi = s[B].split(y, factor=tile_size_y)
        xo, xi = s[B].split(x, factor=tile_size_x)

        # Choose different reordering based on problem size
        if out_channels >= 64:
            # For larger problems, parallelize over channels
            s[B].reorder(fo, no, yo, xo, ni, fi, yi, xi)
            if self.parallel:
                s[B].parallel(fo)  # Parallelize over output channels
        else:
            # For smaller problems, focus on spatial locality
            s[B].reorder(no, fo, yo, xo, ni, fi, yi, xi)
            if self.parallel:
                # Choose whether to parallelize batch or channels
                if batch_size > 1:
                    s[B].parallel(no)
                else:
                    s[B].parallel(fo)

        # Apply vectorization to the innermost loop if the width is large enough
        if out_width >= 16:
            s[B].vectorize(xi)

        # Build the function
        if self.has_bias:
            self.func = tvm.build(s, [A, W, bias, B], target="llvm", name="conv2d_o1")
            self.output_tvm = tvm.nd.empty((batch_size, out_channels, out_height, out_width), 
                                        dtype=self.dtype, device=tvm.cpu())
        else:
            self.func = tvm.build(s, [A, W, B], target="llvm", name="conv2d_o1")
            self.output_tvm = tvm.nd.empty((batch_size, out_channels, out_height, out_width), 
                                        dtype=self.dtype, device=tvm.cpu())

    def process(self):
        # Execute the function
        if self.has_bias:
            self.func(self.input_tvm, self.weight_tvm, self.bias_tvm, self.output_tvm)
        else:
            self.func(self.input_tvm, self.weight_tvm, self.output_tvm)
        
        return self.output_tvm.numpy()


if __name__ == "__main__":
    # Test the convolution with a simple example
    batch_size, in_channels, in_height, in_width = 1, 3, 32, 32
    out_channels, kernel_height, kernel_width = 16, 3, 3
    
    x_np = np.random.rand(batch_size, in_channels, in_height, in_width).astype(np.float32)
    w_np = np.random.rand(out_channels, in_channels, kernel_height, kernel_width).astype(np.float32)
    b_np = np.random.rand(out_channels).astype(np.float32)
    
    # Verify with PyTorch
    x_torch = torch.tensor(x_np, dtype=torch.float32)
    w_torch = torch.tensor(w_np, dtype=torch.float32)
    b_torch = torch.tensor(b_np, dtype=torch.float32)
    expected = torch.nn.functional.conv2d(x_torch, w_torch, b_torch).numpy()

    # Test with TVM
    benchmark = BenchmarkConv2dTVMO1()
    result = benchmark.benchmark(x_np, w_np, expected, b_np, 1, 0, 1, 1, False)
    result_parallel = benchmark.benchmark(x_np, w_np, expected, b_np, 1, 0, 1, 1, True)

    print(f"{result}")
    print(f"parallel: {result_parallel}") 

