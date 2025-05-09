import numpy as np
import tvm
from tvm import te
import tvm.testing
import torch
from tvm import autotvm
import time
import os


@autotvm.template("softmax_tune")
def softmax(N, M, dtype):
    X = te.placeholder((N, M), name="X", dtype=dtype)

    k = te.reduce_axis((0, M), name="k")

    max = te.compute((N,), lambda i: te.max(X[i, k], axis=k), name="max")
    exp = te.compute((N, M), lambda i, j: te.exp(X[i, j] - max[i]), name="exp")
    k = te.reduce_axis((0, M), name="k")
    sum = te.compute((N,), lambda i: te.sum(exp[i, k], axis=k), name="sum")

    output = te.compute((N, M), lambda i, j: exp[i, j] / sum[i], name="output")

    s = te.create_schedule(output.op)

    cfg = autotvm.get_config()
    cfg.define_split("tile_x", output.op.axis[0], num_outputs=2, max_factor=128)
    cfg.define_split("tile_y", output.op.axis[1], num_outputs=2, max_factor=128)

    xo, xi = cfg["tile_x"].apply(s, output, output.op.axis[0])
    yo, yi = cfg["tile_y"].apply(s, output, output.op.axis[1])

    s[output].parallel(xo)
    s[output].vectorize(yi)

    return s, [X, output]


def benchmark_autotvm(shape, a_np, axis=-1):
    # FIXME: axis is not used in this benchmark
    N, M = shape

    task = autotvm.task.create("softmax_tune", args=(N, M, "float32"), target="llvm")
    measure_option = autotvm.measure_option(
        builder=autotvm.LocalBuilder(), runner=autotvm.LocalRunner(number=5)
    )
    log_path = os.path.join(os.path.dirname(__file__), "softmax_tuning_autotvm.log")

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

    with autotvm.apply_history_best("softmax_tuning_autotvm.log"):
        with tvm.target.Target("llvm"):
            s, arg_bufs = softmax(N, M, "float32")
            func = tvm.build(s, arg_bufs)

    dev = tvm.cpu()
    a_tvm = tvm.nd.array(a_np, device=dev)
    output_tvm = tvm.nd.empty((N, M), dtype="float32", device=dev)

    # Warm up.
    for _ in range(25):
        func(a_tvm, output_tvm)
    times = []
    # Repeat to execute.
    for _ in range(100):
        start = time.perf_counter()
        func(a_tvm, output_tvm)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), a_tvm.numpy(), tune_time


if __name__ == "__main__":
    N = M = 512
    shape = (N, M)

    a_np = np.random.uniform(size=(N, M)).astype(np.float32)
    time_autotvm, result_autotvm, tuning_time = benchmark_autotvm(shape, a_np)

    # FIXME: Pass verification with torch.
    # x_torch = torch.tensor(a_np, dtype=torch.float32)
    # ref = torch.softmax(x_torch, 1)
    # assert np.allclose(
    #     ref, result_autotvm, atol=1e-3, rtol=1e-3
    # ), f"tvm result mismatch!"
    print(f"res: {time_autotvm} tuning time:{tuning_time}")
    
