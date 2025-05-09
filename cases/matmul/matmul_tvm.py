# TVM Benchmark
# Refer to: https://tvm.apache.org/docs/deep_dive/tensor_ir/tutorials/tir_creation.html

import numpy as np
# `np.float_` is deprecated after numpy 2.0, but it is used in tvm
np.float_ = np.float64
import time
import tvm
from tvm.script import ir as I
from tvm.script import tir as T
from tvm import te, tir, auto_scheduler

@I.ir_module
class TVMMatmul:
    @T.prim_func
    def matmul(
        M: T.int32, N: T.int32, K: T.int32,
        a: T.handle, b: T.handle, c: T.handle,
        parallel: T.bool
    ):
        A = T.match_buffer(a, [M, K], "float32")
        B = T.match_buffer(b, [K, N], "float32")
        C = T.match_buffer(c, [M, N], "float32")

        if parallel:
            for i in T.parallel(M):
                for j, k in T.grid(N, K):
                    with T.block("C"):
                        vi, vj, vk = T.axis.remap("SSR", [i, j, k])
                        with T.init():
                            C[vi, vj] = 0.0
                        C[vi, vj] += A[vi, vk] * B[vk, vj]
        else:
            for i, j, k in T.grid(M, N, K):  # 单线程执行
                with T.block("C"):
                    vi, vj, vk = T.axis.remap("SSR", [i, j, k])
                    with T.init():
                        C[vi, vj] = 0.0
                    C[vi, vj] += A[vi, vk] * B[vk, vj]


def benchmark_tvm(shape, a_np, b_np, parallel=True):
    M, N, K = shape
    lib = tvm.build(TVMMatmul, args=[M, N, K, parallel], target="llvm")
    a = tvm.nd.array(a_np)
    b = tvm.nd.array(b_np)
    c = tvm.nd.array(np.zeros((M, N), dtype="float32"))
    times = []
    # Warmup.
    for _ in range(25):
        lib(M, N, K, a, b, c, parallel)
    
    # Repeat to execute.
    for _ in range(100):
        start = time.perf_counter()
        lib(M, N, K, a, b, c, parallel)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy()


def benchmark_tvm_single(shape, a_np, b_np):
    return benchmark_tvm(shape, a_np, b_np, parallel=False)


if __name__ == "__main__":
    M = N = K = 512
    a_np = np.random.rand(M, K).astype(np.float32)
    b_np = np.random.rand(K, N).astype(np.float32)
    shape = (M, N, K)
    time_tvm, result_tvm = benchmark_tvm(shape, a_np, b_np)
    time_tvm_single, result_tvm_single = benchmark_tvm_single(shape, a_np, b_np)
    assert np.allclose(result_tvm, result_tvm_single, atol=1e-3, rtol=1e-3), f"tvm result mismatch!"
    print(f"tvm: {time_tvm}, tvm_single: {time_tvm_single}")
