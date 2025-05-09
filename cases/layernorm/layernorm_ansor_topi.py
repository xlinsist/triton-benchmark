import contextlib
import os
import time
import numpy as np
import tvm
from tvm import te, auto_scheduler
import torch
from tvm import topi


# a context manager that redirect all standard output to devnull
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


# layernorm call from topi library
@auto_scheduler.register_workload
def layernorm(N, M, dtype):
    A = te.placeholder((N, M), name="A", dtype=dtype)

    Gamma = te.placeholder((M,), name="Gamma")
    Beta = te.placeholder((M,), name="Beta")

    C = topi.nn.layer_norm(A, Gamma, Beta, axis=(1,))

    return [A, Gamma, Beta, C]


def benchmark_ansor(shape, a_np):
    target = tvm.target.Target("llvm")
    N, M = shape
    task = tvm.auto_scheduler.SearchTask(
        func=layernorm, args=(N, M, "float32"), target=target
    )

    # print("Computational DAG:")
    # print(task.compute_dag)

    log_file = "ansor_layernorm_topi.json"
    tune_option = auto_scheduler.TuningOptions(
        num_measure_trials=10,
        early_stopping=10,
        measure_callbacks=[auto_scheduler.RecordToFile(log_file)],
        verbose=0,
    )

    with suppress_all_output():
        tune_start = time.perf_counter()
        task.tune(tune_option)
        tune_end = time.perf_counter()

    tune_time = tune_end - tune_start

    sch, args = task.apply_best(log_file)
    # print("Lowered TIR:")
    # print(tvm.lower(sch, args, simple_mode=True))

    func = tvm.build(sch, args, target)

    dev = tvm.cpu()

    a_tvm = tvm.nd.array(a_np, device=dev)
    gamma = tvm.nd.array(np.ones((M,), dtype="float32"))
    beta = tvm.nd.array(np.zeros((M,), dtype="float32"))
    result = tvm.nd.array(np.zeros((N, M), dtype="float32"))

    for _ in range(25):
        func(a_tvm, gamma, beta, result)
    times = []
    for _ in range(100):
        start = time.perf_counter()
        func(a_tvm, gamma, beta, result)
        end = time.perf_counter()
        times.append(end - start)

    return np.mean(times), result.numpy(), tune_time


if __name__ == "__main__":

    N = M = 512
    shape = (N, M)

    a_np = np.random.uniform(size=(N, M)).astype(np.float32)

    time_ansor, result_ansor, tuning_time = benchmark_ansor(shape, a_np.copy())

    a = torch.tensor(a_np.copy(), device="cpu", dtype=torch.float32)

    with torch.no_grad():
        result_torch = torch.nn.LayerNorm(a.shape[1])(a)

    assert np.allclose(
        result_ansor, result_torch, atol=1e-3, rtol=1e-3
    ), f"tvm result mismatch!"

    print(f"ansor: {time_ansor} tuning time:{tuning_time}")
