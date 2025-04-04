import numpy as np
import time
import hidet
from hidet.lang import attrs
from hidet.lang.types import f32
from hidet.lang import printf, grid
from hidet.lang.mapping import spatial, repeat


def compile_hidet_vecadd(N, parallel=True):
    with hidet.script_module() as script_module:
        @hidet.script
        def hidet_vecadd(a: hidet.float32[N], b: hidet.float32[N], c: hidet.float32[N]):
            attrs.func_kind = 'cpu_kernel'
            if parallel:
                for i in grid(N, attrs='p'):
                    c[i] = a[i] + b[i]
            else:
                for i in range(N):
                    c[i] = a[i] + b[i]
    return script_module.build()


def benchmark_hidet(N, a_np, b_np, parallel=True):
    hidet.option.cache_dir('./.hidet/cache')
    module = compile_hidet_vecadd(N, parallel)
    a, b, c = hidet.graph.from_numpy(a_np), hidet.graph.from_numpy(b_np), hidet.empty([N])

    times = [time.perf_counter() for _ in range(10) if not module(a, b, c) or True]
    return (times[-1] - times[0]) / 10, c.numpy()


def benchmark_hidet_single(N, a_np, b_np):
    return benchmark_hidet(N, a_np, b_np, parallel=False)


if __name__ == "__main__":
    N = 1024
    a_np = np.random.rand(N).astype(np.float32)
    b_np = np.random.rand(N).astype(np.float32)
    time_hidet, result_hidet = benchmark_hidet(N, a_np, b_np)
    time_hidet_single, result_hidet_single = benchmark_hidet_single(N, a_np, b_np)
    assert np.allclose(result_hidet, result_hidet_single, atol=1e-3, rtol=1e-3), f"hidet result mismatch!"
    print(f"hidet: {time_hidet}, hidet_single: {time_hidet_single}")
