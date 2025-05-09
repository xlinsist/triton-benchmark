import contextlib
import os
import time
import numpy as np
import tvm
from tvm import te, auto_scheduler

from matmul_tvm import benchmark_tvm
from tvm import topi


@contextlib.contextmanager
def suppress_all_output():
    """a context manager that redirect all standard output to devnull"""
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
def matmul(N, K, M, dtype):
    A = te.placeholder((N, K), name="A", dtype=dtype)
    B = te.placeholder((K, M), name="B", dtype=dtype)
    C = topi.nn.matmul(A, B)

    return [A, B, C]


def benchmark_ansor(shape, a_np, b_np):
    target = tvm.target.Target("llvm")
    N, K, M = shape
    task = tvm.auto_scheduler.SearchTask(
        func=matmul, args=(N, K, M, "float32"), target=target
    )

    log_path = os.path.join(os.path.dirname(__file__), "ansor_matmul_topi.json")
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
    a_tvm = tvm.nd.array(a_np, device=dev)
    b_tvm = tvm.nd.array(b_np, device=dev)
    c_np = np.dot(a_np, b_np)
    c_tvm = tvm.nd.empty(c_np.shape)

    # Warm up.
    for _ in range(25):
        func(a_tvm, b_tvm, c_tvm)

    times = []
    # Repeat to execute.
    for _ in range(100):
        start = time.perf_counter()
        func(a_tvm, b_tvm, c_tvm)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), c_tvm.numpy(), tune_time


if __name__ == "__main__":
    N = K = M = 512
    shape = (N, K, M)

    a_np = np.random.uniform(size=(N, K)).astype(np.float32)
    b_np = np.random.uniform(size=(K, M)).astype(np.float32)

    time_ansor, result_ansor, tuning_time = benchmark_ansor(shape, a_np, b_np)
    time_tvm, result_tvm = benchmark_tvm(shape, a_np, b_np)
    assert np.allclose(
        result_ansor, result_tvm, atol=1e-3, rtol=1e-3
    ), f"tvm result mismatch!"
    print(f"ansor: {time_ansor} tuning time:{tuning_time}")
