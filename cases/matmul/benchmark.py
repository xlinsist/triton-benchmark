import pandas as pd
import numpy as np

from matmul_torch import benchmark_torch
from matmul_hidet import benchmark_hidet
from matmul_tvm import benchmark_tvm
from matmul_triton import benchmark_triton
from matmul_autotvm import benchmark_autotvm
from matmul_ansor import benchmark_ansor

benchmark = "matmul"

def run_benchmark(method_name, method_func, shape, a_np, b_np):
    
    # NOTE: Keep the returned parameter "result" here even though it is not used.
    exec_time, result, *rest = method_func(shape, a_np, b_np)
    tuning_time = rest[0] if rest else 0.0
    return {
        'Benchmark': benchmark, 
        'Shape': shape, 
        'Method': method_name, 
        'Time(s)': exec_time, 
        'TuningTime(s)': tuning_time
    }


def main():
    shapes = [(64, 64, 64), (128, 128, 128), (256, 256, 256)]
    records = []

    for shape in shapes:
        a_np, b_np = (np.random.rand(shape[0], shape[2]).astype(np.float32), 
                       np.random.rand(shape[2], shape[1]).astype(np.float32))
        methods = [
            ("torch", benchmark_torch),
            ("hidet", benchmark_hidet),
            ("tvm", benchmark_tvm),
            ("triton", benchmark_triton),
            ("autotvm", benchmark_autotvm),
            ("ansor", benchmark_ansor),
        ]
        for method, method_func in methods:
            print(f"Running {method} benchmark for shape {shape}...")
            records.append(run_benchmark(method, method_func, shape, a_np, b_np))

    df = pd.DataFrame(records)
    df.sort_values(by=['Benchmark', 'Shape'], inplace=True)
    df['Speedup'] = df.apply(
        lambda row: round(df[
        (df['Benchmark'] == row['Benchmark']) & 
        (df['Shape'] == row['Shape']) & 
        (df['Method'] == 'torch')
        ]['Time(s)'].values[0] / row['Time(s)'], 4), axis=1
    )

    print(df)
    df.to_csv("./performance_report.csv", index=False)


if __name__ == "__main__":
    main()
