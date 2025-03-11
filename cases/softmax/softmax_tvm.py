# TVM Benchmark
# Refer to: https://tvm.apache.org/docs/reference/api/python/topi.html#tvm.topi.nn.softmax

import numpy as np

# `np.float_` is deprecated after numpy 2.0, but it is used in tvm
np.float_ = np.float64
import time
import tvm
from tvm.script import ir as I
from tvm.script import tir as T
from tvm import te, tir, auto_scheduler


def benchmark_tvm(a_np, axis=-1):
    times = []
    a = tvm.nd.array(a_np)
    result = tvm.nd.array(np.zeros(a_np.shape, dtype="float32"))

    a_tvm_tensor = tvm.te.placeholder(a_np.shape, dtype="float32")
    result_tensor = tvm.topi.nn.softmax(a_tvm_tensor, axis=axis)
    s = te.create_schedule(result_tensor.op)
    softmax = tvm.build(s, [a_tvm_tensor, result_tensor], "llvm")

    for _ in range(10):
        start = time.perf_counter()
        softmax(a, result)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), result.numpy()


def benchmark_tvm_single(a_np, axis=-1):
    return benchmark_tvm(a_np, axis=axis)


if __name__ == "__main__":
    N = 512
    a_np = np.random.rand(N).astype(np.float32)
    axis = -1

    time_tvm, result_tvm = benchmark_tvm(a_np, axis)
    time_tvm_single, result_tvm_single = benchmark_tvm_single(a_np, axis)

    assert np.allclose(
        result_tvm, result_tvm_single, atol=1e-3, rtol=1e-3
    ), f"tvm result mismatch!"
    print(f"tvm: {time_tvm}, tvm_single: {time_tvm_single}")
