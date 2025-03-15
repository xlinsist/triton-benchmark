import time
import torch
import numpy as np
import multiprocessing
import pandas as pd

from matmul_hidet import benchmark_hidet, benchmark_hidet_single
from matmul_tvm import benchmark_tvm, benchmark_tvm_single
from matmul_triton import benchmark_triton, benchmark_triton_single
from matmul_autotvm import benchmark_autotvm
from matmul_ansor import benchmark_ansor

benchmark = "matmul"

def benchmark_torch(a_np, b_np, num_threads=None):
    """Benchmark PyTorch matmul performance."""
    a = torch.tensor(a_np, dtype=torch.float32)
    b = torch.tensor(b_np, dtype=torch.float32)
    
    if num_threads is None:
        num_threads = multiprocessing.cpu_count()
    torch.set_num_threads(num_threads)

    times = [time.perf_counter() - time.perf_counter() for _ in range(10)]
    for i in range(10):
        start = time.perf_counter()
        result = torch.matmul(a, b)
        end = time.perf_counter()
        times[i] = end - start

    with torch.no_grad():
        result_np = result.numpy()
    
    return np.mean(times), result_np

def run_benchmark(method_name, method_func, shape, a_np, b_np, torch_result):
    """Run a single benchmark and validate results."""
    exec_time, result, *rest = method_func(shape, a_np, b_np)
    tune_time = rest[0] if rest else 0.0
    
    assert np.allclose(result, torch_result, atol=1e-3, rtol=1e-3), f"{method_name} result mismatch!"
    
    return {
        'Benchmark': benchmark, 
        'Shape': shape, 
        'Method': method_name, 
        'Time(s)': exec_time, 
        # TODO: Capture triton's tuning time
        'TuningTime(s)': tune_time
    }

def main():
    """Main function to benchmark different matrix multiplication methods."""
    shape = (512, 512, 512)
    a_np, b_np = (np.random.rand(shape[0], shape[2]).astype(np.float32), 
                   np.random.rand(shape[2], shape[1]).astype(np.float32))
    records = []
    
    # Torch benchmark as baseline
    print(f"Running torch benchmark...")
    torch_time, torch_result = benchmark_torch(a_np, b_np)
    records.append({'Benchmark': benchmark, 'Shape': shape, 'Method': 'torch', 'Time(s)': torch_time, 'TuningTime(s)': 0.0})
    print(f"Running torch_single benchmark...")
    torch_time_single, _ = benchmark_torch(a_np, b_np, 1)
    records.append({'Benchmark': benchmark, 'Shape': shape, 'Method': 'torch_single', 'Time(s)': torch_time_single, 'TuningTime(s)': 0.0})
    
    # Other methods
    # TODO:fix trtion result mismatch
    methods = [
        ('hidet', benchmark_hidet), ('tvm', benchmark_tvm),('triton',benchmark_triton), ('autotvm', benchmark_autotvm),('ansor',benchmark_ansor),
        ('hidet_single', benchmark_hidet_single), ('tvm_single', benchmark_tvm_single), ('triton_single', benchmark_triton_single)
    ]
    
    for method, method_func in methods:
        print(f"Running {method} benchmark...")
        records.append(run_benchmark(method, method_func, shape, a_np, b_np, torch_result))
    
    df = pd.DataFrame(records)
    df.sort_values(by=['Benchmark', 'Shape'], inplace=True)
    print(df)
    df.to_csv("./performance_report.csv", index=False)

if __name__ == "__main__":
    main()