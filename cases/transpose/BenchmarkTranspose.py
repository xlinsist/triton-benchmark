from abc import ABC, abstractmethod
import numpy as np
import time

from config import measurement_iterations, warmup_iterations

class BenchmarkTranspose(ABC):

    def __init__(self, name, parallelable):
        self.name = name
        self.parallelable = parallelable
        self.parallel = False

    @abstractmethod
    def process(self, x):
        """ Where processing really happens

        Args:
            x: transformed input data, like torch tensor or tvm NDArray

        Returns:
            Processed data in the form of ndarray of numpy.
            (Because some frameworks like hidet and tvm have `lazy execution`,
            transform the result directly in this function trigger the execution,
            or there will be some strange bugs)

        """
        pass

    @abstractmethod
    def preprocess(self, x_np):
        pass

    def benchmark(self, x_np, parallel = False):
        self.parallel = parallel
        x = self.preprocess(x_np)

        times = []
        result = []
        for _ in range(measurement_iterations):
            start = time.perf_counter()
            result = self.process(x)
            end = time.perf_counter()
            times.append(round((end - start) * 1000, 3))
        
        return np.mean(times[warmup_iterations:]), np.array(result), times[:warmup_iterations]

