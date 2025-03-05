# Hidet Benchmark
# Refer to: https://hidet.org/docs/stable/gallery/hidet-script/3-kernel-functions.html

import numpy as np
import time
import hidet
from hidet.lang import attrs
from hidet.lang.types import f32

def benchmark_hidet(M, N, K, a_np, b_np):
    hidet.option.cache_dir('./.hidet/cache')
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


# hidet.option.cache_dir('./.hidet/cache')

# with hidet.script_module() as script_module:

#     @hidet.script
#     def matmul(a: f32[16, 16], b: f32[16, 16], c: f32[16, 16]):
#         # specify the function kind as 'cpu_kernel'
#         attrs.func_kind = 'cpu_kernel'

#         for i in range(16):
#             for j in range(16):
#                 c[i, j] = 0.0
#                 for k in range(16):
#                     c[i, j] += a[i, k] * b[k, j]


# module = script_module.build()

# a = hidet.randn([16, 16])
# b = hidet.randn([16, 16])
# c = hidet.empty([16, 16])

# module(a, b, c)
# # We can check the generated source code to see that the ``launch`` function is generated automatically.
# print(module.source())
# # compare the result with torch.matmul

# hidet.utils.assert_close(c, a.torch() @ b.torch(), atol=1e-3, rtol=1e-3)
# print(c)
# print(a.torch() @ b.torch())
