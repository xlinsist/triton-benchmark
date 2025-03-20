import numpy as np
import hidet
from BenchmarkTranspose import BenchmarkTranspose

class BenchmarkHidet(BenchmarkTranspose):

    def __init__(self):
        super().__init__('hidet', False)

    def preprocess(self, x_np):
        return hidet.graph.from_numpy(x_np)

    def process(self, x):
        return hidet.ops.transpose(x).numpy()

if __name__ == "__main__":
    M, N = 1024, 768
    x_np = np.random.rand(M, N).astype(np.float32)

    benchmark = BenchmarkHidet()
    time_hidet, result_hidet, warmup_times = benchmark.benchmark(x_np)

    # Verify correctness
    expected = x_np.transpose()
    assert np.allclose(result_hidet, expected, atol=1e-3, rtol=1e-3), (
        "Hidet result mismatch!"
    )

    print(f"hidet: {time_hidet}, warmup times: {warmup_times}")
