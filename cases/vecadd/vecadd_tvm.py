import numpy as np
# `np.float_` is deprecated after numpy 2.0, but it is used in tvm
np.float_ = np.float64
import time
import tvm
from tvm.script import ir as I
from tvm.script import tir as T
from tvm import te, tir

def schedule_vector_add(N):
    A = te.placeholder((N,), name="A", dtype="float32")
    B = te.placeholder((N,), name="B", dtype="float32")
    C = te.compute((N,), lambda i: A[i] + B[i], name="C")
    s = te.create_schedule(C.op)
    i = C.op.axis[0]
    i_outer, i_inner = s[C].split(i, factor=64)
    s[C].parallel(i_outer)
    s[C].vectorize(i_inner)
    return s, [A, B, C]

def benchmark_tvm(N, a_np, b_np):
    s, args = schedule_vector_add(N)
    func = tvm.build(s, args, target="llvm")
    a = tvm.nd.array(a_np)
    b = tvm.nd.array(b_np)
    c = tvm.nd.array(np.zeros(N, dtype="float32"))
    times = []
    for _ in range(10):
        start = time.perf_counter()
        func(a, b, c)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy()

if __name__ == "__main__":
    N = 1024 * 1024
    a_np = np.random.rand(N).astype(np.float32)
    b_np = np.random.rand(N).astype(np.float32)
    time_tvm, result_tvm = benchmark_tvm(N, a_np, b_np)
    print(f"TVM time: {time_tvm}")
