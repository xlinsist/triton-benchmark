import numpy as np
import tvm
from tvm import te
import tvm.topi as topi
from BenchmarkTranspose import BenchmarkTranspose

class BenchmarkTVMNaive(BenchmarkTranspose):

    def __init__(self):
        super().__init__('tvm-naive', False)
        
    def preprocess(self, x_np):
        # Create TVM context and tensors
        self.M, self.N = x_np.shape
        self.dtype = str(x_np.dtype)
        
        # Define the computation
        A = te.placeholder((self.M, self.N), name='A', dtype=self.dtype)
        B: tvm.te.Tensor = topi.transpose(A)
        
        # Create schedule
        s = te.create_schedule(B.op)
        
        # Build the function
        self.func = tvm.build(s, [A, B], target="llvm", name="transpose")
        
        # Create TVM arrays
        self.a_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.b_tvm = tvm.nd.empty((self.N, self.M), dtype=self.dtype, device=tvm.cpu())
        
        return self.a_tvm
        
    def process(self, x):
        # Execute the function
        self.func(x, self.b_tvm)
        return self.b_tvm.numpy()

class BenchmarkTVMO1(BenchmarkTranspose):
    """Optimized with parallelism, vectorize and loop tiling"""

    def __init__(self):
        super().__init__('tvm-o1', False)

    def preprocess(self, x_np):
        self.M, self.N = x_np.shape
        self.dtype = str(x_np.dtype)

        A = te.placeholder((self.M, self.N), name='A', dtype=self.dtype)
        B: tvm.te.Tensor = topi.transpose(A)

        s: tvm.te.schedule.Schedule = te.create_schedule(B.op)

        block_size = 32  # TODO: Tune this based on CPU cache line size
        x, y = s[B].op.axis

        # **Loop Tiling (Cache Optimization)**
        xo, _ = s[B].split(x, factor=block_size)
        _, yi = s[B].split(y, factor=block_size)

        s[B].parallel(xo)  # Parallelize the outer loop
        s[B].vectorize(yi)  # Apply vectorization to the inner loop

        # Build the optimized function
        self.func = tvm.build(s, [A, B], target="llvm", name="transpose")

        # Allocate TVM arrays
        self.a_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.b_tvm = tvm.nd.empty((self.N, self.M), dtype=self.dtype, device=tvm.cpu())

        return self.a_tvm

    def process(self, x):
        # Execute the compiled function
        self.func(x, self.b_tvm)
        return self.b_tvm.numpy()

if __name__ == "__main__":
    M, N = 1024, 768
    x_np = np.random.rand(M, N).astype(np.float32)

    benchmark = BenchmarkTVMO1()
    time_tvm, result_tvm, warmup_times = benchmark.benchmark(x_np)

    # Verify correctness
    expected = x_np.transpose()
    assert np.allclose(result_tvm, expected, atol=1e-3, rtol=1e-3), (
        "TVM result mismatch!"
    )

    print(f"tvm: {time_tvm}, warmup times: {warmup_times}") 
