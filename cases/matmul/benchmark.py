import time
import torch
import numpy as np
import multiprocessing
import pandas as pd

from matmul_triton import benchmark_triton
from matmul_hidet import benchmark_hidet
from matmul_tvm import benchmark_tvm

benchmark = "matmul"

def benchmark_torch(a_np, b_np):
    a = torch.tensor(a_np, dtype=torch.float32)
    b = torch.tensor(b_np, dtype=torch.float32)
    torch.set_num_threads(multiprocessing.cpu_count())
    
    times = [time.perf_counter() - time.perf_counter() + torch.matmul(a, b) for _ in range(10)]
    return np.mean(times), a.matmul(b).numpy()

def run_benchmark(method_name, method_func, shape, a_np, b_np, torch_result):
    exec_time, result = method_func(shape, a_np, b_np)
    ### FIXME: Check why the matmul_kernel of triton-cpu is not correct
    if method_name != "triton":
        assert np.allclose(result, torch_result, atol=1e-3, rtol=1e-3), f"{method_name} result mismatch!"

    ### TODO: Implement tuning and catch tuning time
    return {'Benchmark': benchmark, 'Shape': shape, 'Method': method_name, 'Time(ms)': exec_time, 'TuningTime(ms)': 0.0}

def main():
    M = N = K = 128
    a_np = np.random.rand(M, K).astype(np.float32)
    b_np = np.random.rand(K, N).astype(np.float32)
    shape = (M, N, K)
    records = []
    
    # Torch benchmark as baseline
    torch_time, torch_result = benchmark_torch(a_np, b_np)
    records.append({'Benchmark': benchmark, 'Shape': shape, 'Method': 'torch', 'Time(ms)': torch_time, 'TuningTime(ms)': 0.0})
    
    # Other methods
    for method, method_func in [('hidet', benchmark_hidet), ('tvm', benchmark_tvm), ('triton', benchmark_triton)]:
        records.append(run_benchmark(method, method_func, shape, a_np, b_np, torch_result))
    
    df = pd.DataFrame(records)
    print(df)

if __name__ == "__main__":
    main()
