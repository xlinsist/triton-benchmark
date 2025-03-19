# Hidet Benchmark
# Refer to: https://hidet.org/docs/stable/gallery/hidet-script/3-kernel-functions.html

import numpy as np
import time
import hidet


def benchmark_hidet(a_np, axis=-1):
    hidet.option.cache_dir("./.hidet/cache")
    shape = a_np.shape

    a = hidet.graph.from_numpy(a_np)
    b = hidet.empty(shape)

    times = []
    for _ in range(10):
        start = time.perf_counter()
        b = hidet.ops.softmax(a, axis)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), b.numpy()


if __name__ == "__main__":
    N = 512
    a_np = np.random.rand(N).astype(np.float32)
    axis = -1

    # benchmark
    start = time.perf_counter()
    time_hidet, result_hidet = benchmark_hidet(a_np, axis)
    end = time.perf_counter()
    time_hidet = end - start
    print("time_hidet", time_hidet)

    # torch
    import torch

    a = torch.tensor(a_np.copy(), device="cpu", dtype=torch.float32)
    start = time.perf_counter()
    with torch.no_grad():
        result_torch = torch.nn.functional.softmax(a, axis)
    end = time.perf_counter()
    time_torch = end - start
    print("time_torch", time_torch)

    assert np.allclose(
        result_hidet, result_torch, atol=1e-3, rtol=1e-3
    ), f"hidet result mismatch!"
    print("pass")
