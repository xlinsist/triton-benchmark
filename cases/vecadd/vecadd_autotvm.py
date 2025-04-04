import numpy as np
import tvm
from tvm import te
import tvm.testing
from tvm import autotvm
import time
from vecadd_tvm import benchmark_tvm


@autotvm.template("vector_add_tune")
def vector_add(N, dtype):
    A = te.placeholder((N,), name="A", dtype=dtype)
    B = te.placeholder((N,), name="B", dtype=dtype)
    C = te.compute((N,), lambda i: A[i] + B[i], name="C")
    s = te.create_schedule(C.op)

    i = s[C].op.axis[0]

    cfg = autotvm.get_config()
    cfg.define_split("tile_i", i, num_outputs=2)

    io, ii = cfg["tile_i"].apply(s, C, i)

    s[C].reorder(io, ii)
    return s, [A, B, C]


def benchmark_autotvm(N, a_np, b_np):
    task = autotvm.task.create("vector_add_tune", args=(N, "float32"), target="llvm")
    measure_option = autotvm.measure_option(
        builder="local", runner=autotvm.LocalRunner(number=5)
    )

    tuner = autotvm.tuner.RandomTuner(task)
    tune_start = time.perf_counter()
    tuner.tune(
        n_trial=10,
        measure_option=measure_option,
        callbacks=[autotvm.callback.log_to_file("vector_add_tuning_autotvm.log")],
    )
    tune_end = time.perf_counter()
    tune_time = tune_end - tune_start

    with autotvm.apply_history_best("vector_add_tuning_autotvm.log"):
        with tvm.target.Target("llvm"):
            s, arg_bufs = vector_add(N, "float32")
            func = tvm.build(s, arg_bufs)
    c_np = a_np + b_np
    c_tvm = tvm.nd.empty(c_np.shape)
    times = []
    for _ in range(10):
        start = time.perf_counter()
        func(tvm.nd.array(a_np), tvm.nd.array(b_np), c_tvm)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c_tvm.numpy(), tune_time


if __name__ == "__main__":
    N = 1024 * 1024
    a_np = np.random.uniform(size=(N,)).astype(np.float32)
    b_np = np.random.uniform(size=(N,)).astype(np.float32)
    time_autotvm, result_autotvm, tuning_time = benchmark_autotvm(N, a_np, b_np)
    time_tvm, result_tvm = benchmark_tvm(N, a_np, b_np)
    assert np.allclose(
        result_autotvm, result_tvm, atol=1e-3, rtol=1e-3
    ), f"tvm result mismatch!"
    print(f"autotvm time: {time_autotvm}, tuning time: {tuning_time}")
