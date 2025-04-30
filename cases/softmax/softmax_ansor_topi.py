import contextlib
import os
import time
import numpy as np
import tvm
from tvm import te, auto_scheduler
import torch
from tvm import topi


@contextlib.contextmanager
def suppress_all_output():
    null_device = os.devnull
    stdout_fd = os.dup(1)

    with open(null_device, "w") as devnull:
        os.dup2(devnull.fileno(), 1)  # redirect stdout
        try:
            yield
        finally:
            os.dup2(stdout_fd, 1)
            os.close(stdout_fd)


@auto_scheduler.register_workload
def softmax_topi(N, M, dtype):

    X = te.placeholder((N, M), name="X", dtype=dtype)

    C = topi.nn.softmax(X)
    return [X, C]


def benchmark_ansor(shape, x_np):
    target = tvm.target.Target("llvm")
    N, M = shape

    task = tvm.auto_scheduler.SearchTask(
        func=softmax_topi, args=(N, M, "float32"), target=target
    )

    log_path = os.path.join(os.path.dirname(__file__), "ansor_softmax_topi.json")
    tune_option = auto_scheduler.TuningOptions(
        num_measure_trials=10,
        measure_callbacks=[auto_scheduler.RecordToFile(log_path)],
        verbose=0,
    )

    # Get tuning time.
    with suppress_all_output():
        tune_start = time.perf_counter()
        task.tune(tune_option)
        tune_end = time.perf_counter()
    tune_time = tune_end - tune_start

    sch, args = task.apply_best(log_path)
    func = tvm.build(sch, args, target)
    dev = tvm.cpu()
    x_tvm = tvm.nd.array(x_np, device=dev)
    output_tvm = tvm.nd.empty(x_np.shape)

    # Warm up.
    for _ in range(5):
        func(x_tvm, output_tvm)

    times = []
    # Repeat to execute.
    for _ in range(10):
        start = time.perf_counter()
        func(x_tvm, output_tvm)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), output_tvm.numpy(), tune_time


if __name__ == "__main__":
    N = M = 512
    shape = (N, M)

    x_np = np.random.uniform(size=(N, M)).astype(np.float32)

    time_ansor, result_ansor, tuning_time = benchmark_ansor(shape, x_np)
    x_torch = torch.tensor(x_np, dtype=torch.float32)
    with torch.no_grad():
        ref = torch.softmax(x_torch, 1)
    assert np.allclose(ref, result_ansor, atol=1e-3, rtol=1e-3), f"tvm result mismatch!"
    print(f"ansor_topi: {time_ansor} tuning time:{tuning_time}")
