# Hidet Benchmark
# Refer to: https://hidet.org/docs/stable/gallery/hidet-script/3-kernel-functions.html

import numpy as np
import time
import hidet
from hidet.lang import attrs
from hidet.lang.types import f32, i32
from hidet.lang import printf, grid
from hidet.lang.mapping import spatial, repeat


def benchmark_hidet(a_np, axis=-1, parallel=True):
    hidet.option.cache_dir("./.hidet/cache")
    shape = a_np.shape
    # module = compile_hidet_softmax(shape, axis)

    a = hidet.graph.from_numpy(a_np)
    b = hidet.empty(shape)

    times = []
    for _ in range(10):
        start = time.perf_counter()
        b = hidet.ops.softmax(a, axis)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), b.numpy()


def benchmark_hidet_single(a_np, axis=-1):
    return benchmark_hidet(a_np, axis=axis, parallel=False)


if __name__ == "__main__":
    N = 512
    a_np = np.random.rand(N).astype(np.float32)
    axis = -1

    # warmup
    benchmark_hidet(a_np, axis)

    # benchmark
    time_hidet, result_hidet = benchmark_hidet(a_np, axis)
    time_hidet_single, result_hidet_single = benchmark_hidet_single(a_np, axis)

    assert np.allclose(
        result_hidet, result_hidet_single, atol=1e-3, rtol=1e-3
    ), f"hidet result mismatch!"
    print(f"hidet: {time_hidet}, hidet_single: {time_hidet_single}")
