from abc import ABC, abstractmethod
import numpy as np
import time
import config

class BenchmarkConv2d(ABC):

    def __init__(self, name, parallelable):
        self.name = name
        self.parallelable = parallelable
        self.parallel = False

    @abstractmethod
    def process(self):
        pass

    @abstractmethod
    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        pass

    def execute(self):
        """Helper function to execute operations"""
        times = []
        result = []
        for _ in range(config.measurement_iterations):
            start = time.perf_counter()
            result = self.process()
            end = time.perf_counter()
            times.append(round((end - start) * 1000, 3))

        return np.mean(times[config.warmup_iterations:]), np.array(result), times[:config.warmup_iterations]

    def benchmark(self, x_np, w_np, expected, b_np=None, stride=1, padding=0, dilation=1, groups=1, parallel=False):
        """ Run benchmark
        Conventions:
            Pass all arguments to `preprocess()` except `expected` and `parallel`, `preprocess()` will store result in `self`.
            Run the benchmark and return a dict for output
        Args:
            x_np: Input tensor of shape (batch_size, in_channels, in_height, in_width)
            w_np: Filter tensor of shape (out_channels, in_channels//groups, kernel_height, kernel_width)
            b_np: Optional bias tensor of shape (out_channels)
            stride: Int or tuple of (stride_h, stride_w). Default: 1
            padding: Int or tuple of (padding_h, padding_w). Default: 0
            dilation: Int or tuple of (dilation_h, dilation_w). Default: 1
            groups: Number of blocked connections from input to output channels. Default: 1
        """
        self.parallel = parallel
        self.preprocess(x_np, w_np, b_np, stride, padding, dilation, groups)

        name=  self.name + ('_parallel' if parallel else '')
        print(f"  Running {name}...")
        exec_time, result, warmup_times = self.execute()

        assert np.allclose(result, expected, atol=1e-3, rtol=1e-3), f"{name} result mismatch!"

        return {
            'Benchmark': config.benchmark,
            'Shape': f"input: {x_np.shape}, out: {w_np.shape}",
            'Method': name,
            'Time(ms)': exec_time,
            'WarmUpTimes(ms)': warmup_times
        }

