# Hidet Benchmark
# Refer to: https://hidet.org/docs/stable/gallery/hidet-script/3-kernel-functions.html

import numpy as np
import time
import hidet
from hidet.lang import attrs
from hidet.lang.types import f32
from hidet.lang import printf, grid
from hidet.lang.mapping import spatial, repeat
import os

def compile_hidet_matmul(M, N, K, parallel=True):
    with hidet.script_module() as script_module:
        @hidet.script
        def hidet_matmul(a: hidet.float32[M, K], b: hidet.float32[K, N], c: hidet.float32[M, N]):
            attrs.func_kind = 'cpu_kernel'
            if parallel:
                for i in grid(M, attrs='p'):
                    for j in range(N):
                        c[i, j] = 0.0
                        for k in range(K):
                            c[i, j] += a[i, k] * b[k, j]
            else:
                for i in range(M):
                    for j in range(N):
                        c[i, j] = 0.0
                        for k in range(K):
                            c[i, j] += a[i, k] * b[k, j]
    return script_module.build()


def benchmark_hidet(shape, a_np, b_np, parallel=True):
    log_path = os.path.join(os.path.dirname(__file__), ".hidet/cache")
    hidet.option.cache_dir(log_path)
    M, N, K = shape
    module = compile_hidet_matmul(M, N, K, parallel)
    a, b, c = hidet.graph.from_numpy(a_np), hidet.graph.from_numpy(b_np), hidet.empty([M, N])
    
    times = [time.perf_counter() for _ in range(10) if not module(a, b, c) or True]
    return (times[-1] - times[0]) / 10, c.numpy()


def benchmark_hidet_single(shape, a_np, b_np):
    return benchmark_hidet(shape, a_np, b_np, parallel=False)


if __name__ == "__main__":
    M = N = K = 512
    a_np = np.random.rand(M, K).astype(np.float32)
    b_np = np.random.rand(K, N).astype(np.float32)
    shape = (M, N, K)
    time_hidet, result_hidet = benchmark_hidet(shape, a_np, b_np)
    time_hidet_single, result_hidet_single = benchmark_hidet_single(shape, a_np, b_np)
    assert np.allclose(result_hidet, result_hidet_single, atol=1e-3, rtol=1e-3), f"hidet result mismatch!"
    print(f"hidet: {time_hidet}, hidet_single: {time_hidet_single}")
