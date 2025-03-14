import time
import torch
import numpy as np
import multiprocessing
import pandas as pd
import triton
import triton.language as tl
import os

from transpose_triton import benchmark_triton, benchmark_triton_single
from transpose_hidet import benchmark_hidet, benchmark_hidet_single
# from transpose_tvm import benchmark_tvm, benchmark_tvm_single

benchmark = "transpose"

def benchmark_torch(x_np, num_threads=None):
    """Benchmark PyTorch transpose performance."""
    x = torch.tensor(x_np, dtype=torch.float32)
    
    if num_threads is None:
        num_threads = multiprocessing.cpu_count()
    torch.set_num_threads(num_threads)

    times = []
    for _ in range(10):
        start = time.perf_counter()
        result = torch.transpose(x, 0, 1).contiguous()  # Make contiguous for fair comparison
        end = time.perf_counter()
        times.append(end - start)

    with torch.no_grad():
        result_np = result.numpy()
    
    return np.mean(times), result_np

def run_benchmark(method_name, method_func, shape, x_np, torch_result):
    """Run a single benchmark and validate results."""
    exec_time, result, *rest = method_func(shape, x_np)
    tune_time = rest[0] if rest else 0.0
    
    assert np.allclose(result, torch_result, atol=1e-3, rtol=1e-3), f"{method_name} result mismatch! Expected {torch_result}, got {result}"
    
    return {
        'Benchmark': benchmark, 
        'Shape': shape, 
        'Method': method_name, 
        'Time(ms)': exec_time, 
        'TuningTime(ms)': tune_time
    }

def main():
    """Main function to benchmark different transpose methods."""
    shapes = [(1024, 768), (2048, 1536), (4096, 3072)]
    records = []
    
    for shape in shapes:
        M, N = shape
        x_np = np.random.rand(M, N).astype(np.float32)
        
        # Torch benchmark as baseline
        print(f"Running torch benchmark for shape {shape}...")
        torch_time, torch_result = benchmark_torch(x_np)
        records.append({'Benchmark': benchmark, 'Shape': shape, 'Method': 'torch', 'Time(ms)': torch_time, 'TuningTime(ms)': 0.0})
        
        print(f"Running torch_single benchmark for shape {shape}...")
        torch_time_single, _ = benchmark_torch(x_np, 1)
        records.append({'Benchmark': benchmark, 'Shape': shape, 'Method': 'torch_single', 'Time(ms)': torch_time_single, 'TuningTime(ms)': 0.0})
        
        # Other methods
        methods = [
            ('triton', benchmark_triton), 
            ('triton_single', benchmark_triton_single),
            # ('hidet', benchmark_hidet),
            # ('hidet_single', benchmark_hidet_single),
            # ('tvm', benchmark_tvm),
            # ('tvm_single', benchmark_tvm_single)
        ]
        
        for method, method_func in methods:
            print(f"Running {method} benchmark for shape {shape}...")
            records.append(run_benchmark(method, method_func, shape, x_np, torch_result))
    
    df = pd.DataFrame(records)
    df.sort_values(by=['Benchmark', 'Shape'], inplace=True)
    print(df)
    df.to_csv("./transpose_performance_report.csv", index=False)

if __name__ == "__main__":
    main() 
