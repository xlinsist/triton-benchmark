import tvm
from tvm import te, topi
from tvm import auto_scheduler

import contextlib
import os

from BenchmarkConv2d import BenchmarkConv2d, run_benchmarks


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
def conv2d(input_shape, weight_shape, has_bias, stride, padding, dilation, groups, dtype):
    data = te.placeholder(input_shape, name="data", dtype=dtype)
    kernel = te.placeholder(weight_shape, name="kernel", dtype=dtype)
    out = topi.nn.conv(data, kernel, stride, padding, dilation, groups, "NCHW", out_dtype=dtype)
    if has_bias:
        bias = te.placeholder((weight_shape[0],), name="bias", dtype=dtype)
        out = topi.add(out, topi.reshape(bias, (1, weight_shape[0], 1, 1)))
        return [data, kernel, bias, out]
    return [data, kernel, out]

class BenchmarkConv2dAnsor(BenchmarkConv2d):

    def __init__(self):
        super().__init__('tvm_ansor', False)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        stride = (stride, stride) if isinstance(stride, int) else stride
        padding = (padding, padding) if isinstance(padding, int) else padding
        dilation = (dilation, dilation) if isinstance(dilation, int) else dilation
        self.has_bias = b_np is not None

        # prepare tvm tensors
        self.input_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.weight_tvm = tvm.nd.array(w_np, device=tvm.cpu())
        self.bias_tvm = tvm.nd.array(b_np, device=tvm.cpu()) if self.has_bias else None

        out_height = (x_np.shape[2] + 2 * padding[0] - dilation[0] * (w_np.shape[2] - 1) - 1) // stride[0] + 1
        out_width = (x_np.shape[3] + 2 * padding[1] - dilation[1] * (w_np.shape[3] - 1) - 1) // stride[1] + 1
        self.out_tvm = tvm.nd.empty((x_np.shape[0], w_np.shape[0], out_height, out_width))

        # create task
        target = tvm.target.Target("llvm")
        task = auto_scheduler.SearchTask(
            func=conv2d,
            args=(x_np.shape, w_np.shape, self.has_bias, stride, padding, dilation, groups, str(x_np.dtype)),
            target=target
        )

        # print("Computational DAG for conv2d auto_scheduler:")
        # print(task.compute_dag)

        # tune
        log_file = "conv2d-auto_scheduler.json"
        tune_option = auto_scheduler.TuningOptions(
            num_measure_trials=10, # TODO: How many trials will be good?
            measure_callbacks=[auto_scheduler.RecordToFile(log_file)],
            verbose=2,
        )
        with suppress_all_output():
            tuning_time = self.measure(task.tune, tune_option)

        sch, args = task.apply_best(log_file)
        self.func = tvm.build(sch, args, "llvm")

        # print("Lowered TIR:")
        # print(tvm.lower(sch, args, simple_mode=True))

        return tuning_time

    def process(self):
        if self.has_bias:
            self.func(self.input_tvm, self.weight_tvm, self.bias_tvm, self.out_tvm)
        else:
            self.func(self.input_tvm, self.weight_tvm, self.out_tvm)
        return self.out_tvm.numpy()


if __name__ == "__main__":
    benchmark = BenchmarkConv2dAnsor()
    df = run_benchmarks([benchmark])
    print(f"\nBenchmark Results:\n{df}")

