import torch
import triton
import triton.language as tl
import os

from BenchmarkTranspose import BenchmarkTranspose, run_benchmarks

def get_configs():
    configs = []
    for BLOCK_SIZE_M in [16, 32, 64, 128]:
        for BLOCK_SIZE_N in [16, 32, 64, 128]:
            configs.append(triton.Config({'BLOCK_SIZE_M': BLOCK_SIZE_M, 'BLOCK_SIZE_N': BLOCK_SIZE_N}))
    return configs

@triton.autotune(get_configs(), key=['M', 'N'])
@triton.jit
def transpose_kernel(
    input_ptr, output_ptr,
    M, N,
    input_stride_m, input_stride_n,
    output_stride_m, output_stride_n,
    BLOCK_SIZE_M: tl.constexpr, BLOCK_SIZE_N: tl.constexpr
):
    pid = tl.program_id(axis=0)
    num_pid_n = tl.cdiv(N, BLOCK_SIZE_N)
    pid_m = pid // num_pid_n
    pid_n = pid % num_pid_n

    offs_m = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    offs_n = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)

    input_ptrs = input_ptr + offs_m[:, None] * input_stride_m + offs_n[None, :] * input_stride_n
    mask = (offs_m[:, None] < M) & (offs_n[None, :] < N)

    block = tl.load(input_ptrs, mask=mask)
    block_t = tl.trans(block)

    # NOTE: we need to swap m and n for the output
    output_ptrs = output_ptr + offs_n[:, None] * output_stride_m + offs_m[None, :] * output_stride_n
    mask_t = tl.trans(mask)
    tl.store(output_ptrs, block_t, mask=mask_t)

class BenchmarkTransposeTriton(BenchmarkTranspose):

    def __init__(self):
        super().__init__('triton', True)

    def preprocess(self, x_np):
        os.environ["TRITON_CPU_BACKEND"] = "1"
        os.environ["TRITON_CPU_MAX_THREADS"] = "0" if self.parallel else "1"
        M, N = x_np.shape

        self.x = torch.tensor(x_np, device='cpu', dtype=torch.float32)
        self.y = torch.empty((N, M), dtype=self.x.dtype, device=self.x.device)
        self.grid = lambda META: (triton.cdiv(M, META['BLOCK_SIZE_M']) * triton.cdiv(N, META['BLOCK_SIZE_N']), )

        # for debug
        self.already_print = False

        return self.measure(self.process)

    def process(self):
        M, N = self.x.shape
        transpose_kernel[self.grid](
            self.x, self.y,
            M, N,
            self.x.stride(0), self.x.stride(1),
            self.y.stride(0), self.y.stride(1),
        )

        if not self.already_print:
            print(f"    Best config: {transpose_kernel.best_config}")
            self.already_print = True

        return self.y

if __name__ == "__main__":
    benchmark = BenchmarkTransposeTriton()
    df = run_benchmarks([benchmark])
    print(f"\nBenchmark Results:\n{df}")
