# TVM Benchmark
# Refer to: https://tvm.apache.org/docs/deep_dive/tensor_ir/tutorials/tir_creation.html

import numpy as np
# `np.float_` is deprecated after numpy 2.0, but it is used in tvm
np.float_ = np.float64
import time
import tvm
from tvm.script import ir as I
from tvm.script import tir as T

@I.ir_module
class TVMMatmul:
    @T.prim_func
    def matmul(
        M: T.int32, N: T.int32, K: T.int32,
        a: T.handle, b: T.handle, c: T.handle
    ):
        A = T.match_buffer(a, [M, K], "float32")
        B = T.match_buffer(b, [K, N], "float32")
        C = T.match_buffer(c, [M, N], "float32")
        for i, j, k in T.grid(M, N, K):
            with T.block("C"):
                vi, vj, vk = T.axis.remap("SSR", [i, j, k])
                with T.init():
                    C[vi, vj] = 0.0
                C[vi, vj] += A[vi, vk] * B[vk, vj]


def benchmark_tvm(shape, a_np, b_np):
    M, N, K = shape
    lib = tvm.build(TVMMatmul, args=[M, N, K], target="llvm")
    a = tvm.nd.array(a_np)
    b = tvm.nd.array(b_np)
    c = tvm.nd.array(np.zeros((M, N), dtype="float32"))
    times = []
    for _ in range(10):
        start = time.perf_counter()
        lib(M, N, K, a, b, c)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy()


if __name__ == "__main__":
    M = N = K = 128
    a_np = np.random.rand(M, K).astype(np.float32)
    b_np = np.random.rand(K, N).astype(np.float32)
    shape = (M, N, K)
    benchmark_tvm(shape, a_np, b_np)
