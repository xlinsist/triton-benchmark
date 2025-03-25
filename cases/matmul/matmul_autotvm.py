# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

import numpy as np
import tvm
from tvm import te
import tvm.testing

from tvm import autotvm
import time
from matmul_tvm import benchmark_tvm


@autotvm.template("matmul_tune")
def matmul(N, L, M, dtype):
    A = te.placeholder((N, L), name="A", dtype=dtype)
    B = te.placeholder((L, M), name="B", dtype=dtype)

    k = te.reduce_axis((0, L), name="k")
    C = te.compute((N, M), lambda i, j: te.sum(A[i, k] * B[k, j], axis=k), name="C")
    s = te.create_schedule(C.op)

    y, x = s[C].op.axis
    k = s[C].op.reduce_axis[0]

    cfg = autotvm.get_config()
    cfg.define_split("tile_y", y, num_outputs=2)
    cfg.define_split("tile_x", x, num_outputs=2)

    yo, yi = cfg["tile_y"].apply(s, C, y)
    xo, xi = cfg["tile_x"].apply(s, C, x)

    # TODO: Check if autotvm can tuning params other than split factors, e.g. num_thread, unroll factor, vectorization factor, etc.
    s[C].reorder(yo, xo, k, yi, xi)
    return s, [A, B, C]


def benchmark_autotvm(shape, a_np, b_np):
    N, L, M = shape

    task = autotvm.task.create("matmul_tune", args=(N, L, M, "float32"), target="llvm")
    measure_option = autotvm.measure_option(
        builder="local", runner=autotvm.LocalRunner(number=5)
    )

    tuner = autotvm.tuner.RandomTuner(task)
    tune_start = time.perf_counter()
    tuner.tune(
        n_trial=10,
        measure_option=measure_option,
        callbacks=[autotvm.callback.log_to_file("matmul_tuning_autotvm.log")],
    )
    tune_end = time.perf_counter()
    tune_time = tune_end - tune_start

    with autotvm.apply_history_best("matmul_tuning_autotvm.log"):
        with tvm.target.Target("llvm"):
            s, arg_bufs = matmul(N, L, M, "float32")
            func = tvm.build(s, arg_bufs)
    c_np = a_np.dot(b_np)
    c_tvm = tvm.nd.empty(c_np.shape)
    times = []
    for _ in range(10):
        start = time.perf_counter()
        func(tvm.nd.array(a_np), tvm.nd.array(b_np), c_tvm)
        end = time.perf_counter()
        times.append(end - start)
    return np.mean(times), c_tvm.numpy(), tune_time


if __name__ == "__main__":
    N = L = M = 512
    shape = (N, L, M)

    a_np = np.random.uniform(size=(N, L)).astype(np.float32)
    b_np = np.random.uniform(size=(L, M)).astype(np.float32)

    time_autotvm, result_autotvm, tuning_time = benchmark_autotvm(shape, a_np, b_np)
    time_tvm, result_tvm = benchmark_tvm(shape, a_np, b_np)
    assert np.allclose(
        result_autotvm, result_tvm, atol=1e-3, rtol=1e-3
    ), f"tvm result mismatch!"
    print(f"tvm: {time_autotvm} tuning time:{tuning_time}")
