import time
import torch
import numpy as np
import multiprocessing
import pandas as pd

from vecadd_hidet import benchmark_hidet
from vecadd_tvm import benchmark_tvm
from vecadd_triton import benchmark_triton
from vecadd_autotvm import benchmark_autotvm


benchmark = "vecadd"


def benchmark_torch(a_np, b_np, num_threads=None):
    """Benchmark PyTorch vecadd performance."""

    a = torch.tensor(a_np, dtype=torch.float32)
    b = torch.tensor(b_np, dtype=torch.float32)

    if num_threads is None:
        num_threads = multiprocessing.cpu_count()
    torch.set_num_threads(num_threads)
    _ = torch.add(a, b)
    times = [time.perf_counter() - time.perf_counter() for _ in range(10)]
    for i in range(10):
        start = time.perf_counter()
        result = torch.add(a, b)
        end = time.perf_counter()
        times[i] = end - start

    with torch.no_grad():
        result_np = result.numpy()

    return np.mean(times), result_np


def run_benchmark(method_name, method_func, shape, a_np, b_np, torch_result):
    """Run a single benchmark and validate results."""

    exec_time, result, *rest = method_func(shape, a_np, b_np)
    tuning_time = rest[0] if rest else 0.0

    assert np.allclose(result, torch_result, atol=1e-3, rtol=1e-3), f"{method_name} result mismatch!"

    return {
        'Benchmark': benchmark,
        'Shape': shape,
        'Method': method_name,
        'Time(s)': exec_time,
        'TuningTime(s)': tuning_time
    }


def main():
    """Main function to benchmark different vector addition methods."""
    custom_sizes = [2 ** i for i in range(12, 28)]
    records = []
    for shape in custom_sizes:
        a_np, b_np = (np.random.rand(shape).astype(np.float32),
                      np.random.rand(shape).astype(np.float32))
    # Torch benchmark as baseline
        print(f"Running torch benchmark for shape {shape}...")
        torch_time, torch_result = benchmark_torch(a_np, b_np)
        records.append(
            {'Benchmark': benchmark, 'Shape': shape, 'Method': 'torch', 'Time(s)': torch_time, 'TuningTime(s)': 0.0})

        # Other methods
        # TODO: Add more methods.
        methods = [
            ('hidet', benchmark_hidet),
            ('tvm', benchmark_tvm),
            ('triton', benchmark_triton),
            ('autotvm', benchmark_autotvm)
        ]

        for method, method_func in methods:
            print(f"Running {method} benchmark for shape {shape}...")
            run_benchmark(method, method_func, shape, a_np, b_np, torch_result)
            records.append(run_benchmark(method, method_func, shape, a_np, b_np, torch_result))

    df = pd.DataFrame(records)
    df.sort_values(by=['Benchmark', 'Shape'], inplace=True)
    df['Speedup'] = df.apply(
        lambda row: round(df[
                              (df['Benchmark'] == row['Benchmark']) &
                              (df['Shape'] == row['Shape']) &
                              (df['Method'] == 'torch')
                              ]['Time(s)'].values[0] / row['Time(s)'], 4), axis=1
    )

    time_table = df.pivot(index='Shape', columns='Method', values='Time(s)')
    print("Execution Time Table:")
    print(time_table)

    speedup_table = df.pivot(index='Shape', columns='Method', values='Speedup')
    print("\nSpeedup Table:")
    print(speedup_table)

    tuning_time_table = df.pivot(index='Shape', columns='Method', values='TuningTime(s)')
    print("\nTuning Time Table:")
    print(tuning_time_table)

    avg_stats = df.groupby('Method').agg(
        {'Time(s)': 'mean', 'Speedup': 'mean', 'TuningTime(s)': 'mean'})
    print("\nAverage Statistics Table:")
    print(avg_stats)
    df.to_csv("./performance_report.csv", index=False)


if __name__ == "__main__":
    main()

