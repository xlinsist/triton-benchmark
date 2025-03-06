# Hidet Benchmark
# Refer to: https://hidet.org/docs/stable/gallery/hidet-script/3-kernel-functions.html

import numpy as np
import time
import hidet
from hidet.lang import attrs
from hidet.lang.types import f32
from hidet.lang.mapping import spatial, repeat

def benchmark_hidet(shape, a_np, b_np):
    hidet.option.cache_dir('./.hidet/cache')
    M, N, K = shape
    with hidet.script_module() as script_module:
        @hidet.script
        def hidet_matmul(a: hidet.float32[M, K], b: hidet.float32[K, N], c: hidet.float32[M, N]):
            attrs.func_kind = 'cpu_kernel'
            for i in range(M):
                for j in range(N):
                    c[i, j] = 0.0
                    for k in range(K):
                        c[i, j] += a[i, k] * b[k, j]
    module = script_module.build()
    a, b, c = hidet.graph.from_numpy(a_np), hidet.graph.from_numpy(b_np), hidet.empty([M, N])
    times = []
    for _ in range(10):
        start = time.perf_counter()
        module(a, b, c)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy()

if __name__ == "__main__":
    M = N = K = 128
    a_np = np.random.rand(M, K).astype(np.float32)
    b_np = np.random.rand(K, N).astype(np.float32)
    shape = (M, N, K)
    benchmark_hidet(shape, a_np, b_np)
