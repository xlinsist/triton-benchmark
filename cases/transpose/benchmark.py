import torch
import multiprocessing

from BenchmarkTranspose import BenchmarkTranspose, run_benchmarks
from transpose_triton import BenchmarkTransposeTriton
from transpose_hidet import BenchmarkTransposeHidet
from transpose_tvm import BenchmarkTransposeTVMNaive, BenchmarkTransposeTVMO1

class BenchmarkTransposeTorch(BenchmarkTranspose):

    def __init__(self):
        super().__init__('torch', True)

    def preprocess(self, x_np):
        num_threads = multiprocessing.cpu_count() if self.parallel else 1
        torch.set_num_threads(num_threads)
        self.x = torch.tensor(x_np, device='cpu', dtype=torch.float32)
        return 0.0

    def process(self):
        return torch.transpose(self.x, 0, 1).contiguous().numpy()

benchmarks: list[BenchmarkTranspose] = [
    BenchmarkTransposeTorch(),
    BenchmarkTransposeTriton(),
    BenchmarkTransposeTVMNaive(),
    BenchmarkTransposeTVMO1(),
    BenchmarkTransposeHidet(),
    # ('autotvm', benchmark_autotvm),
]

def main():
    df = run_benchmarks(benchmarks)
    df['Speedup'] = df.apply(
        lambda row: round(df[
        (df['Benchmark'] == row['Benchmark']) &
        (df['Shape'] == row['Shape']) &
        (df['Method'] == 'torch')
        ]['Time(s)'].values[0] / row['Time(s)'], 3), axis=1
    )
    print(f"\nBenchmark Results:\n{df}")
    df.to_csv("./conv2d_performance_report.csv", index=False)

if __name__ == "__main__":
    main()

