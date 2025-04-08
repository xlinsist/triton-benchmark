import hidet
from BenchmarkTranspose import BenchmarkTranspose, run_benchmarks

class BenchmarkTransposeHidet(BenchmarkTranspose):

    def __init__(self):
        super().__init__('hidet', False)

    def preprocess(self, x_np):
        self.x = hidet.graph.from_numpy(x_np)
        return 0.0

    def process(self):
        return hidet.ops.transpose(self.x).numpy()

if __name__ == "__main__":
    benchmark = BenchmarkTransposeHidet()
    df = run_benchmarks([benchmark])
    print(f"\nBenchmark Results:\n{df}")

