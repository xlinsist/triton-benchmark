import time
import torch
import numpy as np
import multiprocessing

from matmul_triton import benchmark_triton
from matmul_hidet import benchmark_hidet
from matmul_tvm import benchmark_tvm

# Matrix size and type
M = N = K = 128
dtype = torch.float32

# Generate the same input matrices for all implementations
a_np = np.random.rand(M, K).astype(np.float32)
b_np = np.random.rand(K, N).astype(np.float32)

def benchmark_torch():
    a = torch.tensor(a_np, dtype=dtype)
    b = torch.tensor(b_np, dtype=dtype)
    torch.set_num_threads(multiprocessing.cpu_count())
    times = []
    for _ in range(10):
        start = time.perf_counter()
        c = torch.matmul(a, b)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c.numpy()

def main():
    torch_time, torch_result = benchmark_torch()
    hidet_time, hidet_result = benchmark_hidet(M, N, K, a_np, b_np)
    tvm_time, tvm_result = benchmark_tvm(M, N, K, a_np, b_np)
    triton_time, triton_result = benchmark_triton(M, N, K, a_np, b_np)
    
    print(f"Torch Time: {torch_time:.6f} sec")
    print(f"Hidet Time: {hidet_time:.6f} sec")
    print(f"TVM Time: {tvm_time:.6f} sec")
    print(f"Triton Time: {triton_time:.6f} sec")
    
    assert np.allclose(hidet_result, torch_result, atol=1e-3, rtol=1e-3), "Hidet result mismatch!"
    assert np.allclose(tvm_result, torch_result, atol=1e-3, rtol=1e-3), "TVM result mismatch!"

    # ### FIXME: Check whether the matmul_kernel of triton-cpu is not correct
    # assert np.allclose(triton_result, torch_result, atol=1e-3, rtol=1e-3), "Triton result mismatch!"
    print(torch_result)
    print(triton_result)
    # print("Correctness validation passed!")

if __name__ == "__main__":
    main()
