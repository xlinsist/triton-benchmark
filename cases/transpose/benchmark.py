import torch
import numpy as np
import multiprocessing
import pandas as pd

import config
from BenchmarkTranspose import BenchmarkTranspose
from transpose_triton import BenchmarkTriton
from transpose_hidet import BenchmarkHidet
from transpose_tvm import BenchmarkTVMNaive, BenchmarkTVMO1

class BenchmarkTorch(BenchmarkTranspose):

    def __init__(self):
        super().__init__('torch', True)

    def preprocess(self, x_np):
        num_threads = multiprocessing.cpu_count() if self.parallel else 1
        torch.set_num_threads(num_threads)
        return torch.tensor(x_np, device='cpu', dtype=torch.float32)

    def process(self, x):
        return torch.transpose(x, 0, 1).contiguous()

def run_benchmark(benchmark, x_np, expect, parallel=False):
    name = benchmark.name + ('_parallel' if parallel else '')
    print(f"  Running {name}...")
    exec_time, result, warmup_times = benchmark.benchmark(x_np)
    
    assert np.allclose(result, expect, atol=1e-3, rtol=1e-3), f"{name} result mismatch!"
    
    return {
        'Benchmark': config.benchmark, 
        'Shape': x_np.shape, 
        'Method': name, 
        'Time(ms)': exec_time, 
        'WarmUpTimes(ms)': warmup_times
    }

def main():
    """Main function to benchmark different transpose methods."""
    shapes = [(1024, 768), (2048, 1536), (4096, 3072)]
    records = []
    
    for shape in shapes:
        M, N = shape
        print(f"\nBenchmarking shape {shape}...")
        x_np = np.random.rand(M, N).astype(np.float32)
        expect = x_np.T
        
        benchmarks = [
            BenchmarkTorch(),
            BenchmarkTriton(),
            BenchmarkTVMNaive(),
            BenchmarkTVMO1(),
            BenchmarkHidet(),
            # ('autotvm', benchmark_autotvm),
        ]
        
        for benchmark in benchmarks:
            records.append(run_benchmark(benchmark, x_np, expect))
            if config.benchmark_parallel and benchmark.parallelable:
                records.append(run_benchmark(benchmark, x_np, expect, True))
    
    # Create and save the benchmark results
    df = pd.DataFrame(records)
    df["Time(ms)"] = df["Time(ms)"].apply(lambda x: round(x, 3))
    df["WarmUpTimes(ms)"] = df["WarmUpTimes(ms)"].apply(lambda x: ', '.join(f"{t:.3f}" for t in x))
    df.sort_values(by=["Shape"])
    print("\nBenchmark Results:")
    print(df)
    df.to_csv(f"./{config.benchmark}_performance_report.csv", index=False)

if __name__ == "__main__":
    main()

