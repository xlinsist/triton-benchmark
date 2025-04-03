import numpy as np

# `np.float_` is deprecated after numpy 2.0, but it is used in tvm
np.float_ = np.float64
import time
import tvm
from tvm.script import ir as I
from tvm.script import tir as T
from tvm import te, tir, auto_scheduler


@I.ir_module
class TVMVectorAdd:
    @T.prim_func
    def vector_add(
            N: T.int32,
            a: T.handle, b: T.handle, c: T.handle,
            parallel: T.bool
    ):
        A = T.match_buffer(a, [N], "float32")
        B = T.match_buffer(b, [N], "float32")
        C = T.match_buffer(c, [N], "float32")

        if parallel:
            for i in T.parallel(N):
                with T.block("C"):
                    vi = T.axis.remap("S", [i])
                    C[vi] = A[vi] + B[vi]
        else:
            for i in range(N):
                with T.block("C"):
                    vi = T.axis.remap("S", [i])
                    C[vi] = A[vi] + B[vi]


def benchmark_tvm(N, a_np, b_np, parallel=True):
    lib = tvm.build(TVMVectorAdd, args=[N, parallel], target="llvm")
    a = tvm.nd.array(a_np)
    b = tvm.nd.array(b_np)
    c = tvm.nd.array(np.zeros(N, dtype="float32"))
    times = []
    for _ in range(10):
        start = time.perf_counter()
        lib(N, a, b, c, parallel)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy()


def benchmark_tvm_single(N, a_np, b_np):
    return benchmark_tvm(N, a_np, b_np, parallel=False)


if __name__ == "__main__":
    N = 1024 * 1024
    a_np = np.random.rand(N).astype(np.float32)
    b_np = np.random.rand(N).astype(np.float32)
    time_tvm, result_tvm = benchmark_tvm(N, a_np, b_np)
    time_tvm_single, result_tvm_single = benchmark_tvm_single(N, a_np, b_np)
    assert np.allclose(result_tvm, result_tvm_single, atol=1e-3, rtol=1e-3), f"tvm result mismatch!"
    print(f"tvm: {time_tvm}, tvm_single: {time_tvm_single}")
