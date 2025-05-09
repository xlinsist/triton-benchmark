from abc import ABC, abstractmethod
from typing import Callable, List
import numpy as np
import numpy.typing as npt
import time
import pandas as pd

num_warmup = 200
num_execution = 400
benchmark_name = "transpose"

class BenchmarkTranspose(ABC):

    def __init__(self, name, parallelable):
        self.name = name
        self.parallelable = parallelable
        self.parallel = False

    @abstractmethod
    def process(self) -> npt.NDArray:
        pass

    @abstractmethod
    def preprocess(self, x_np) -> float:
        pass

    @staticmethod
    def measure(f: Callable, *args) -> float:
        start = time.perf_counter()
        f(*args)
        end = time.perf_counter()
        return round((end - start), 3)

    def benchmark(self, x_np, expected, parallel = True):
        self.parallel = parallel
        print(f"  Running {self.name}...")

        tuning_time = self.preprocess(x_np)
        result = self.process()
        assert np.allclose(result, expected, atol=1e-3, rtol=1e-3), f"{self.name} result mismatch!"
        times = [self.measure(self.process) for _ in range(num_execution)]
        exec_time = np.mean(times[num_warmup:])

        return {
            'Benchmark': benchmark_name,
            'Shape': f"{x_np.shape}",
            'Method': self.name,
            'Time(s)': exec_time,
            'TuningTime(s)': tuning_time
        }

def run_benchmarks(benchmarks: List[BenchmarkTranspose]):
    shapes = [(4096, 3072)]
    # shapes = [(1024, 768), (2048, 1536), (4096, 3072)]

    records = []
    for shape in shapes:
        M, N = shape
        x_np = np.random.rand(M, N).astype(np.float32)
        expected = x_np.T

        print(f"\nBenchmarking shape {shape}...")
        for benchmark in benchmarks:
            records.append(benchmark.benchmark(x_np, expected))

    # Create and save the benchmark results
    df = pd.DataFrame(records)
    setattr(df, 'name', benchmark_name)

    return df

