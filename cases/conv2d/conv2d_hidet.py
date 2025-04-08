import hidet
from BenchmarkConv2d import BenchmarkConv2d, run_benchmarks


class BenchmarkConv2dHidet(BenchmarkConv2d):
    def __init__(self):
        super().__init__("hidet", False)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        hidet.option.cache_dir("./.hidet/cache")

        # Convert NumPy arrays to Hidet tensors
        self.input = hidet.graph.from_numpy(x_np)
        self.weight = hidet.graph.from_numpy(w_np)
        self.bias = hidet.graph.from_numpy(b_np) if b_np is not None else None

        # Store the convolution parameters
        self.stride = stride
        self.padding = padding
        self.dilation = dilation
        self.groups = groups
        return 0.0

    def process(self):
        # Execute the convolution operation
        output = hidet.ops.conv2d(
            self.input,
            self.weight,
            stride=self.stride,
            padding=self.padding,
            dilations=self.dilation,
            groups=self.groups,
        )

        # Add bias manually if it exists
        if self.bias is not None:
            output = output + self.bias.reshape(
                (1, -1, 1, 1)
            )  # Ensure proper broadcasting

        return output.numpy()


if __name__ == "__main__":
    benchmark = BenchmarkConv2dHidet()
    df = run_benchmarks([benchmark])
    print(f"\nBenchmark Results:\n{df}")

