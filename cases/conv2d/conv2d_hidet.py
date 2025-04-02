# Hidet Benchmark
# Refer to: https://hidet.org/docs/stable/python_api/ops/index.html

import numpy as np
import torch
import hidet
from BenchmarkConv2d import BenchmarkConv2d


class BenchmarkConv2dHidet(BenchmarkConv2d):

    def __init__(self):
        super().__init__('hidet', False)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        hidet.option.cache_dir('./.hidet/cache')

        # Convert NumPy arrays to Hidet tensors
        self.input = hidet.graph.from_numpy(x_np)
        self.weight = hidet.graph.from_numpy(w_np)
        self.bias = hidet.graph.from_numpy(b_np) if b_np is not None else None

        # Store the convolution parameters
        self.stride = stride
        self.padding = padding
        self.dilation = dilation
        self.groups = groups

    def process(self):
        # Execute the convolution operation
        output = hidet.ops.conv2d(
            self.input, 
            self.weight,
            stride=self.stride,
            padding=self.padding,
            dilations=self.dilation,
            groups=self.groups
        )

        # Add bias manually if it exists
        if self.bias is not None:
            output = output + self.bias.reshape((1, -1, 1, 1))  # Ensure proper broadcasting

        return output.numpy()


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

    # Test with Hidet
    benchmark = BenchmarkConv2dHidet()
    result = benchmark.benchmark(x_np, w_np, expected, b_np, 1, 0, 1, 1, False)

    print(f"{result}")

