import time
import torch
import multiprocessing
import numpy as np

def benchmark_torch(shape, a_np, b_np, num_threads=None):

    a = torch.tensor(a_np, dtype=torch.float32)
    b = torch.tensor(b_np, dtype=torch.float32)
    
    if num_threads is None:
        num_threads = multiprocessing.cpu_count()
    torch.set_num_threads(num_threads)

    # Warm up.
    for _ in range(25):
        torch.matmul(a, b)

    times = []
    # Repeat to execute.
    for _ in range(100):
        start = time.perf_counter()
        result = torch.matmul(a, b)
        end = time.perf_counter()
        times.append(end - start)

    with torch.no_grad():
        result_np = result.numpy()

    return np.mean(times), result_np
