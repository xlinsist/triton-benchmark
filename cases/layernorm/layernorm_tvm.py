# TVM Benchmark
# Refer to: https://tvm.apache.org/docs/reference/api/python/topi.html#tvm.topi.nn.layer_norm

import numpy as np
import torch

# `np.float_` is deprecated after numpy 2.0, but it is used in tvm
np.float_ = np.float64
import time
import tvm
from tvm import te


def benchmark_tvm(a_np):
    times = []
    shape = a_np.shape

    a = tvm.nd.array(a_np)
    gamma = tvm.nd.array(np.ones((a_np.shape[1],), dtype="float32"))
    beta = tvm.nd.array(np.zeros((a_np.shape[1],), dtype="float32"))
    result = tvm.nd.array(np.zeros(a_np.shape, dtype="float32"))

    a_tvm_tensor = tvm.te.placeholder(shape, dtype="float32", name="a_tvm_tensor")
    gamma_tvm_tensor = tvm.te.placeholder(
        (shape[1],), dtype="float32", name="gamma_tvm_tensor"
    )
    beta_tvm_tensor = tvm.te.placeholder(
        (shape[1],), dtype="float32", name="beta_tvm_tensor"
    )
    result_tensor = tvm.topi.nn.layer_norm(
        a_tvm_tensor, gamma_tvm_tensor, beta_tvm_tensor, axis=(1,)
    )
    s = te.create_schedule(result_tensor.op)
    layernorm = tvm.build(
        s, [a_tvm_tensor, gamma_tvm_tensor, beta_tvm_tensor, result_tensor], "llvm"
    )

    for _ in range(10):
        start = time.perf_counter()
        layernorm(a, gamma, beta, result)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), result.numpy()


def benchmark_tvm_single(a_np):
    return benchmark_tvm(a_np)


if __name__ == "__main__":
    # 固定种子
    np.random.seed(0)

    shape = (512, 512)
    a_np = np.random.rand(shape[0], shape[1]).astype(np.float32)

    # benchmark
    time_tvm, result_tvm = benchmark_tvm(a_np.copy())
    print(f"tvm: {time_tvm}")
    print(result_tvm)

    time_tvm_single, result_tvm_single = benchmark_tvm_single(a_np.copy())
    print(f"tvm_single: {time_tvm_single}")
    print(result_tvm_single)

    # torch
    a = torch.tensor(a_np.copy(), device="cpu", dtype=torch.float32)
    start = time.perf_counter()
    with torch.no_grad():
        result_torch = torch.nn.LayerNorm(a.shape[1])(a)
    end = time.perf_counter()
    time_torch = end - start
    print(f"torch: {time_torch}")
    print(result_torch)

    print(f"tvm: {time_tvm}, tvm_single: {time_tvm_single}")

    assert np.allclose(
        result_tvm, result_torch, atol=1e-3, rtol=1e-3
    ), f"tvm result mismatch!"
    assert np.allclose(
        result_tvm_single, result_torch, atol=1e-3, rtol=1e-3
    ), f"{result_tvm_single} result mismatch!"
    print("pass")
