import tvm
from tvm import te
import tvm.topi as topi
from BenchmarkTranspose import BenchmarkTranspose, run_benchmarks

class BenchmarkTransposeTVMNaive(BenchmarkTranspose):

    def __init__(self):
        super().__init__('tvm-naive', False)

    def preprocess(self, x_np):
        self.dtype = str(x_np.dtype)
        M, N = x_np.shape

        A = te.placeholder((M, N), name='A', dtype=self.dtype)
        B: tvm.te.Tensor = topi.transpose(A)
        s = te.create_schedule(B.op)
        self.func = tvm.build(s, [A, B], target="llvm", name="transpose")

        self.a_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.b_tvm = tvm.nd.empty((N, M), dtype=self.dtype, device=tvm.cpu())

        return 0.0

    def process(self):
        # Execute the function
        self.func(self.a_tvm, self.b_tvm)
        return self.b_tvm.numpy()

class BenchmarkTransposeTVMO1(BenchmarkTranspose):
    """Optimized with parallelism, vectorize and loop tiling"""

    def __init__(self):
        super().__init__('tvm-o1', False)

    def preprocess(self, x_np):
        self.dtype = str(x_np.dtype)
        M, N = x_np.shape

        A = te.placeholder((M, N), name='A', dtype=self.dtype)
        B: tvm.te.Tensor = topi.transpose(A)

        s: tvm.te.schedule.Schedule = te.create_schedule(B.op)

        block_size = 32  # TODO: Tune this based on CPU cache line size
        x, y = s[B].op.axis

        xo, _ = s[B].split(x, factor=block_size)
        _, yi = s[B].split(y, factor=block_size)

        s[B].parallel(xo)  # Parallelize the outer loop
        s[B].vectorize(yi)  # Apply vectorization to the inner loop

        self.func = tvm.build(s, [A, B], target="llvm", name="transpose")
        self.a_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.b_tvm = tvm.nd.empty((N, M), dtype=self.dtype, device=tvm.cpu())

        return 0.0

    def process(self):
        self.func(self.a_tvm, self.b_tvm)
        return self.b_tvm.numpy()

if __name__ == "__main__":
    benchmark = BenchmarkTransposeTVMO1()
    df = run_benchmarks([benchmark])
    print(f"\nBenchmark Results:\n{df}")

