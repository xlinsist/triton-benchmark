from abc import ABC, abstractmethod
from typing import Callable, List
import numpy as np
import numpy.typing as npt
import time
import torch
import pandas as pd


num_warmup = 200
num_execution = 400
benchmark_name = "conv2d"

class BenchmarkConv2d(ABC):

    def __init__(self, name, parallelable):
        self.name = name
        self.parallelable = parallelable
        self.parallel = False

    @abstractmethod
    def process(self) -> npt.NDArray:
        pass

    @abstractmethod
    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups) -> float:
        """Return tuning time if tunable, else return 0"""
        pass

    @staticmethod
    def measure(f: Callable, *args) -> float:
        start = time.perf_counter()
        f(*args)
        end = time.perf_counter()
        return round((end - start), 3)

    def benchmark(self, x_np, w_np, expected, b_np=None, stride=1, padding=0, dilation=1, groups=1, parallel=True):
        """ Run benchmark
        Conventions:
            Pass all arguments to `preprocess()` except `expected` and `parallel`, `preprocess()` will store variables in `self`.
            Run the benchmark and return a dict for output
        Args:
            x_np: Input tensor of shape (batch_size, in_channels, in_height, in_width)
            w_np: Filter tensor of shape (out_channels, in_channels//groups, kernel_height, kernel_width)
            expected: Expected result
            b_np: Optional bias tensor of shape (out_channels)
            stride: Int or tuple of (stride_h, stride_w). Default: 1
            padding: Int or tuple of (padding_h, padding_w). Default: 0
            dilation: Int or tuple of (dilation_h, dilation_w). Default: 1
            groups: Number of blocked connections from input to output channels. Default: 1
        """
        self.parallel = parallel
        print(f"  Running {self.name}...")

        tuning_time = self.preprocess(x_np, w_np, b_np, stride, padding, dilation, groups)
        result = self.process()
        assert np.allclose(result, expected, atol=1e-3, rtol=1e-3), f"{self.name} result mismatch!"
        times = [self.measure(self.process) for _ in range(num_execution)]
        # print(f"    {times}")
        exec_time = np.mean(times[num_warmup:])

        return {
            'Benchmark': benchmark_name,
            'Shape': f"input: {x_np.shape}, out: {w_np.shape}",
            'Method': self.name,
            'Time(s)': exec_time,
            'TuningTime(s)': tuning_time
        }

def run_benchmarks(benchmarks: List[BenchmarkConv2d]):
    configs = [
        # (batch_size, channels_in, height, width, channels_out, kernel_size, stride, padding, dilation, groups)
        # (1, 3, 32, 32, 16, (3, 3), (1, 1), (1, 1), (1, 1), 1),
        # (1, 3, 64, 64, 32, (3, 3), (1, 1), (1, 1), (1, 1), 1),
        # (1, 64, 56, 56, 64, (3, 3), (1, 1), (1, 1), (1, 1), 1),
        (8, 3, 224, 224, 64, (7, 7), (2, 2), (3, 3), (1, 1), 1),  # ResNet first layer
    ]

    records = []
    for config in configs:
        batch_size, channels_in, height, width, channels_out, kernel_size, stride, padding, dilation, groups = config

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

        print(f"Benchmarking with input shape {x_np.shape}, weight shape {w_np.shape}")
        for benchmark in benchmarks:
            records.append(benchmark.benchmark(x_np, w_np, expected, b_np, stride, padding, dilation, groups))


    # Create and save the benchmark results
    df = pd.DataFrame(records)
    df['Speedup'] = df.apply(
        lambda row: round(df[
        (df['Benchmark'] == row['Benchmark']) &
        (df['Shape'] == row['Shape']) &
        (df['Method'] == 'torch')
        ]['Time(s)'].values[0] / row['Time(s)'], 3), axis=1
    )
    setattr(df, 'name', benchmark_name)
    print(f"\nBenchmark Results:\n{df}")

    return df

