import numpy as np
import torch
import tvm
from tvm import te, topi
from tvm import auto_scheduler
from BenchmarkConv2d import BenchmarkConv2d

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

        target = tvm.target.Target("llvm")
        task = auto_scheduler.SearchTask(
            func=conv2d,
            args=(x_np.shape, w_np.shape, self.has_bias, stride, padding, dilation, groups, str(x_np.dtype)),
            target=target
        )

        # print("Computational DAG for conv2d auto_scheduler:")
        # print(task.compute_dag)

        log_file = "conv2d-auto_scheduler.json"
        tune_option = auto_scheduler.TuningOptions(
            num_measure_trials=10, # TODO: How many trials will be good?
            measure_callbacks=[auto_scheduler.RecordToFile(log_file)],
            verbose=2,
        )

        task.tune(tune_option)
        sch, args = task.apply_best(log_file)
        self.func = tvm.build(sch, args, "llvm")

        # print("Lowered TIR:")
        # print(tvm.lower(sch, args, simple_mode=True))

        # prepare tvm tensors
        self.input_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.weight_tvm = tvm.nd.array(w_np, device=tvm.cpu())
        self.bias_tvm = tvm.nd.array(b_np, device=tvm.cpu()) if self.has_bias else None

        out_height = (x_np.shape[2] + 2 * padding[0] - dilation[0] * (w_np.shape[2] - 1) - 1) // stride[0] + 1
        out_width = (x_np.shape[3] + 2 * padding[1] - dilation[1] * (w_np.shape[3] - 1) - 1) // stride[1] + 1
        self.out_tvm = tvm.nd.empty((x_np.shape[0], w_np.shape[0], out_height, out_width))

    def process(self):
        if self.has_bias:
            self.func(self.input_tvm, self.weight_tvm, self.bias_tvm, self.out_tvm)
        else:
            self.func(self.input_tvm, self.weight_tvm, self.out_tvm)
        return self.out_tvm.numpy()


if __name__ == "__main__":
    batch_size, in_channels, in_height, in_width = 1, 3, 32, 32
    out_channels, kernel_height, kernel_width = 16, 3, 3

    x_np = np.random.rand(batch_size, in_channels, in_height, in_width).astype(np.float32)
    w_np = np.random.rand(out_channels, in_channels, kernel_height, kernel_width).astype(np.float32)
    b_np = np.random.rand(out_channels).astype(np.float32)

    x_torch = torch.tensor(x_np, dtype=torch.float32)
    w_torch = torch.tensor(w_np, dtype=torch.float32)
    b_torch = torch.tensor(b_np, dtype=torch.float32)
    expected = torch.nn.functional.conv2d(x_torch, w_torch, b_torch).numpy()

    benchmark = BenchmarkConv2dAnsor()
    result = benchmark.benchmark(x_np, w_np, expected, b_np, 1, 0, 1, 1, False)
    print(f"{result}")

