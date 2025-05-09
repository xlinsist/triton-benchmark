import numpy as np
import tvm
from tvm import te
import tvm.testing

from tvm import autotvm
import time
import os
from matmul_tvm import benchmark_tvm

@autotvm.template("matmul_tune")
def matmul(N, K, M, dtype):
    A = te.placeholder((N, K), name="A", dtype=dtype)
    B = te.placeholder((K, M), name="B", dtype=dtype)

    k = te.reduce_axis((0, K), name="k")
    C = te.compute((N, M), lambda i, j: te.sum(A[i, k] * B[k, j], axis=k), name="C")
    s = te.create_schedule(C.op)

    y, x = s[C].op.axis
    k = s[C].op.reduce_axis[0]

    cfg = autotvm.get_config()
    cfg.define_split("tile_y", y, num_outputs=2)
    cfg.define_split("tile_x", x, num_outputs=2)

    yo, yi = cfg["tile_y"].apply(s, C, y)
    xo, xi = cfg["tile_x"].apply(s, C, x)

    s[C].reorder(yo, xo, k, yi, xi)
    s[C].parallel(yo)
    s[C].vectorize(xi)
    return s, [A, B, C]


def benchmark_autotvm(shape, a_np, b_np):
    N, K, M = shape

    task = autotvm.task.create("matmul_tune", args=(N, K, M, "float32"), target="llvm")
    measure_option = autotvm.measure_option(
        builder="local", runner=autotvm.LocalRunner(number=5)
    )
    log_path = os.path.join(os.path.dirname(__file__), "matmul_tuning_autotvm.log")

    # Get tuning time.
    tuner = autotvm.tuner.RandomTuner(task)
    tune_start = time.perf_counter()
    tuner.tune(
        n_trial=10,
        measure_option=measure_option,
        callbacks=[autotvm.callback.log_to_file(log_path)],
    )
    tune_end = time.perf_counter()
    tune_time = tune_end - tune_start

    with autotvm.apply_history_best(log_path):
        with tvm.target.Target("llvm"):
            s, arg_bufs = matmul(N, K, M, "float32")
            func = tvm.build(s, arg_bufs)
    c_np = a_np.dot(b_np)
    c_tvm = tvm.nd.empty(c_np.shape)

    # Warm up.
    for _ in range(25):
        func(tvm.nd.array(a_np), tvm.nd.array(b_np), c_tvm)

    times = []
    # Repeat to execute.
    for _ in range(100):
        start = time.perf_counter()
        func(tvm.nd.array(a_np), tvm.nd.array(b_np), c_tvm)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), c_tvm.numpy(), tune_time


if __name__ == "__main__":
    N = K = M = 512
    shape = (N, K, M)

    a_np = np.random.uniform(size=(N, K)).astype(np.float32)
    b_np = np.random.uniform(size=(K, M)).astype(np.float32)

    time_autotvm, result_autotvm, tuning_time = benchmark_autotvm(shape, a_np, b_np)
    time_tvm, result_tvm = benchmark_tvm(shape, a_np, b_np)
    assert np.allclose(
        result_autotvm, result_tvm, atol=1e-3, rtol=1e-3
    ), f"tvm result mismatch!"
    print(f"shape:{shape} tvm: {time_autotvm} tuning time:{tuning_time}")
