import time
import torch
import numpy as np
import multiprocessing
import pandas as pd

from transpose_triton import benchmark_triton
# from transpose_hidet import benchmark_hidet
# from transpose_tvm import benchmark_tvm
# from transpose_autotvm import benchmark_autotvm

from config import measurement_iterations, benchmark, benchmark_parallel, warmup_iterations

def benchmark_torch(x_np, parallel):
    """Benchmark PyTorch transpose performance."""
    x = torch.tensor(x_np, dtype=torch.float32)
    
    num_threads = multiprocessing.cpu_count() if parallel else 1
    torch.set_num_threads(num_threads)

    # Measure warm-up time
    warmup_times = []
    for _ in range(warmup_iterations):
        warmup_start = time.perf_counter()
        result = torch.transpose(x, 0, 1).contiguous()
        warmup_end = time.perf_counter()
        warmup_times.append((warmup_end - warmup_start) * 1000)

    # Measure execution time
    times = []
    for _ in range(measurement_iterations):
        start = time.perf_counter()
        result = torch.transpose(x, 0, 1).contiguous()  # Make contiguous for fair comparison
        end = time.perf_counter()
        times.append(end - start)

    with torch.no_grad():
        result_np = result.numpy()
    
    return np.mean(times) * 1000, result_np, warmup_times  # Convert to ms

def run_benchmark(method_name, method_func, x_np, expect, parallel=False):
    """Run a single benchmark and validate results."""
    print(f"  Running {method_name}{'_parallel' if parallel else ''}...")
    exec_time, result, warmup_times = method_func(x_np, parallel)
    
    assert np.allclose(result, expect, atol=1e-3, rtol=1e-3), f"{method_name} result mismatch!"
    
    return {
        'Benchmark': benchmark, 
        'Shape': x_np.shape, 
        'Method': method_name + ('_parallel' if parallel else ''), 
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
        
        # Define all methods
        methods = [
            ('torch', benchmark_torch),
            ('triton', benchmark_triton),
            # ('hidet', benchmark_hidet),
            # ('tvm', benchmark_tvm),
            # ('autotvm', benchmark_autotvm),
        ]
        
        for method, method_func in methods:
            # Run without parallelism
            records.append(run_benchmark(method, method_func, x_np, expect, False))
            
            # Run with parallelism if enabled
            if benchmark_parallel:
                records.append(run_benchmark(method, method_func, x_np, expect, True))
    
    # Create and save the benchmark results
    df = pd.DataFrame(records)
    df["Time(ms)"] = df["Time(ms)"].apply(lambda x: round(x, 3))
    df["WarmUpTimes(ms)"] = df["WarmUpTimes(ms)"].apply(lambda x: ', '.join(f"{t:.3f}" for t in x))
    df.sort_values(by=["Shape"])
    print("\nBenchmark Results:")
    print(df)
    df.to_csv(f"./{benchmark}_performance_report.csv", index=False)

if __name__ == "__main__":
    main() 
