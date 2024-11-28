#include "kernel/iir.h"
#include "support/omp.h"
#include "support/support.h"

void iir(double* b, double* a, const int N, const int nodes, 
            double* input, double* output) {
    std::optional<int> max_threads = getIntEnv("TRITON_CPU_MAX_THREADS");
    if (max_threads.has_value()) {
        max_threads = std::max(1, std::min(max_threads.value(), omp_get_max_threads()));
    } else {
        max_threads = omp_get_max_threads();
    }

    if (getBoolEnv("TRITON_CPU_OMP_DEBUG")) {
        printf("max_threads: %d\n", max_threads.value());
    }

    for (int k = 0; k < nodes; ++k) {

        output[0] = b[k * 3] * input[0];
        output[1] = b[k * 3] * input[1] + b[k * 3 + 1] * input[0] - a[k * 2] * output[0];

#pragma omp parallel for num_threads(max_threads.value())
        for (int i = 2; i < N; ++i) {
            output[i] = b[k * 3] * input[i] + b[k * 3 + 1] * input[i - 1] 
                                            + b[k * 3 + 2] * input[i - 2] 
                                            - a[k * 2] * output[i - 1] 
                                            - a[k * 2 + 1] * output[i - 2];
        }

        for (int i = 0; i < N; ++i) {
            input[i] = output[i];
        }
    }
}