import torch
import multiprocessing

from BenchmarkConv2d import BenchmarkConv2d, run_benchmarks
from conv2d_triton import BenchmarkConv2dTriton
from conv2d_tvm import BenchmarkConv2dTVM
from conv2d_hidet import BenchmarkConv2dHidet
from conv2d_ansor import BenchmarkConv2dAnsor

class BenchmarkConv2dTorch(BenchmarkConv2d):

    def __init__(self):
        super().__init__('torch', True)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        num_threads = multiprocessing.cpu_count() if self.parallel else 1
        torch.set_num_threads(num_threads)

        self.input = torch.tensor(x_np, device='cpu', dtype=torch.float32)
        self.weight = torch.tensor(w_np, device='cpu', dtype=torch.float32)
        self.bias = torch.tensor(b_np, device='cpu', dtype=torch.float32) if b_np is not None else None

        # NOTE: No need to preprocess them here, 'cause conv2d of pytorch will.
        self.stride = stride
        self.padding = padding
        self.dilation = dilation
        self.groups = groups

        return 0.0

    def process(self):
        with torch.no_grad():
            return torch.nn.functional.conv2d(self.input, self.weight, self.bias, self.stride, self.padding, self.dilation, self.groups).numpy()

benchmarks = [
    BenchmarkConv2dTorch(),
    BenchmarkConv2dTriton(),
    BenchmarkConv2dTVM(),
    BenchmarkConv2dHidet(),
    BenchmarkConv2dAnsor()
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
    df.to_csv(f"./{getattr(df, 'name')}_performance_report.csv", index=False)

if __name__ == "__main__":
    main()

