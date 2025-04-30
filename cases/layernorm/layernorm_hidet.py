# Hidet Benchmark
# Refer to: https://hidet.org/docs/stable/python_api/ops/index.html#hidet.ops.layer_norm

import numpy as np
import time
import hidet
import torch


def benchmark_hidet(shape, a_np):
    hidet.option.cache_dir("./.hidet/cache")

    a = hidet.graph.from_numpy(a_np)
    b = hidet.empty(shape)

    times = []
    for _ in range(10):
        start = time.perf_counter()
        b = hidet.ops.layer_norm(a, num_last_dims=1)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), b.numpy()


if __name__ == "__main__":
    shape = (512, 512)
    a_np = np.random.rand(shape[0], shape[1]).astype(np.float32)

    # benchmark
    time_hidet, result_hidet = benchmark_hidet(shape, a_np.copy())
    print(f"hidet: {time_hidet}")
    print(result_hidet)

    # torch
    a = torch.tensor(a_np.copy(), device="cpu", dtype=torch.float32)
    start = time.perf_counter()
    with torch.no_grad():
        result_torch = torch.nn.LayerNorm(a.shape[1])(a)
    end = time.perf_counter()
    time_torch = end - start
    print(f"torch: {time_torch}")
    print(result_torch)

    assert np.allclose(
        result_hidet, result_torch, atol=1e-3, rtol=1e-3
    ), f"hidet result mismatch!"
    print("pass")
