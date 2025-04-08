import tvm
from tvm import te, topi
from BenchmarkConv2d import BenchmarkConv2d, run_benchmarks


class BenchmarkConv2dTVM(BenchmarkConv2d):

    def __init__(self):
        super().__init__('tvm', True)

    def preprocess(self, x_np, w_np, b_np, stride, padding, dilation, groups):
        self.dtype = str(x_np.dtype)
        stride = (stride, stride) if isinstance(stride, int) else stride
        padding = (padding, padding) if isinstance(padding, int) else padding
        dilation = (dilation, dilation) if isinstance(dilation, int) else dilation
        self.has_bias = b_np is not None

        input = te.placeholder(x_np.shape, name='A', dtype=self.dtype)
        weight = te.placeholder(w_np.shape, name='W', dtype=self.dtype)
        out = topi.nn.conv(input, weight, stride, padding, dilation, groups, "NCHW", out_dtype=self.dtype)
        bias = None
        if self.has_bias:
            bias = te.placeholder((weight.shape[0],), name="bias", dtype=self.dtype)
            out = topi.add(out, topi.reshape(bias, (1, weight.shape[0], 1, 1)))
        s = te.create_schedule(out.op)

        # prepare tvm tensors
        self.input_tvm = tvm.nd.array(x_np, device=tvm.cpu())
        self.weight_tvm = tvm.nd.array(w_np, device=tvm.cpu())
        self.bias_tvm = tvm.nd.array(b_np, device=tvm.cpu()) if self.has_bias else None

        out_height = (x_np.shape[2] + 2 * padding[0] - dilation[0] * (w_np.shape[2] - 1) - 1) // stride[0] + 1
        out_width = (x_np.shape[3] + 2 * padding[1] - dilation[1] * (w_np.shape[3] - 1) - 1) // stride[1] + 1
        self.out_tvm = tvm.nd.empty((x_np.shape[0], w_np.shape[0], out_height, out_width))

        if self.has_bias:
            self.func = tvm.build(s, [input, weight, bias, out])
        else:
            self.func = tvm.build(s, [input, weight, out])

        return 0.0

    def process(self):
        if self.has_bias:
            self.func(self.input_tvm, self.weight_tvm, self.bias_tvm, self.out_tvm)
        else:
            self.func(self.input_tvm, self.weight_tvm, self.out_tvm)
        return self.out_tvm.numpy()


if __name__ == "__main__":
    benchmark = BenchmarkConv2dTVM()
    df = run_benchmarks([benchmark])
    print(f"\nBenchmark Results:\n{df}")

