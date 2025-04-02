import torch
import numpy as np
import multiprocessing
import pandas as pd

from BenchmarkConv2d import BenchmarkConv2d
from conv2d_triton import BenchmarkConv2dTriton
from conv2d_tvm import BenchmarkConv2dTVM, BenchmarkConv2dTVMO1
from conv2d_hidet import BenchmarkConv2dHidet
from conv2d_ansor import BenchmarkConv2dAnsor
import config

class BenchmarkConv2dTorch(BenchmarkConv2d):

    def __init__(self):
        super().__init__('torch', True)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        num_threads = multiprocessing.cpu_count() if self.parallel else 1
        torch.set_num_threads(num_threads)

        self.input = torch.tensor(x_np, device='cpu', dtype=torch.float32)
        self.weight = torch.tensor(w_np, device='cpu', dtype=torch.float32)
        self.bias = torch.tensor(b_np, device='cpu', dtype=torch.float32) if b_np is not None else None

        # NOTE: No need to preprocess them here, 'cause conv2d of pytorch will.
        self.stride = stride
        self.padding = padding
        self.dilation = dilation
        self.groups = groups

    def process(self):
        with torch.no_grad():
            return torch.nn.functional.conv2d(self.input, self.weight, self.bias, self.stride, self.padding, self.dilation, self.groups)

def main():
    configs = [
        # (batch_size, channels_in, height, width, channels_out, kernel_size, stride, padding, dilation, groups)
        (1, 3, 32, 32, 16, (3, 3), (1, 1), (1, 1), (1, 1), 1),
        (1, 3, 64, 64, 32, (3, 3), (1, 1), (1, 1), (1, 1), 1),
        (1, 64, 56, 56, 64, (3, 3), (1, 1), (1, 1), (1, 1), 1),
        (8, 3, 224, 224, 64, (7, 7), (2, 2), (3, 3), (1, 1), 1),  # ResNet first layer
    ]
    records = []

    for config_conv2d in configs:
        batch_size, channels_in, height, width, channels_out, kernel_size, stride, padding, dilation, groups = config_conv2d

        # Create input, weight, and bias tensors
        x_np = np.random.rand(batch_size, channels_in, height, width).astype(np.float32)
        w_np = np.random.rand(channels_out, channels_in // groups, kernel_size[0], kernel_size[1]).astype(np.float32)
        b_np = np.random.rand(channels_out).astype(np.float32)

        with torch.no_grad():
            x_torch = torch.tensor(x_np, device='cpu')
            w_torch = torch.tensor(w_np, device='cpu')
            b_torch = torch.tensor(b_np, device='cpu')
            expected = torch.nn.functional.conv2d(
                x_torch, w_torch, b_torch, stride, padding, dilation, groups
            ).numpy()

        benchmarks: list[BenchmarkConv2d] = [
            BenchmarkConv2dTorch(),
            BenchmarkConv2dTriton(),
            BenchmarkConv2dTVM(),
            BenchmarkConv2dTVMO1(),
            BenchmarkConv2dHidet(),
            BenchmarkConv2dAnsor()
        ]

        print(f"Benchmarking with input shape {x_np.shape}, weight shape {w_np.shape}")
        for benchmark in benchmarks:
            records.append(benchmark.benchmark(x_np, w_np, expected, b_np, stride, padding, dilation, groups, False))
            if config.benchmark_parallel and benchmark.parallelable:
                records.append(benchmark.benchmark(x_np, w_np, expected, b_np, stride, padding, dilation, groups, True))

    # Create and save the benchmark results
    df = pd.DataFrame(records)
    df["Time(ms)"] = df["Time(ms)"].apply(lambda x: round(x, 3))
    df["WarmUpTimes(ms)"] = df["WarmUpTimes(ms)"].apply(lambda x: ', '.join(f"{t:.3f}" for t in x))
    print("\nBenchmark Results:")
    print(df)
    df.to_csv(f"./{config.benchmark}_performance_report.csv", index=False)

if __name__ == "__main__":
    main() 
