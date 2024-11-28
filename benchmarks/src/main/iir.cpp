#ifdef C_KERNEL_ENABLE
#include "kernel/iir.h"
#endif

#ifdef TRITON_KERNEL_ENABLE
#include "iir_kernel_launcher.h"
#endif

#include "support/support.h"
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cassert>
#include <cstring>
#include <algorithm>
#include <random>

int main(int argc, char *argv[]) 
{
    int nodes = 3;
    int N = 4096;
    int RUN_COUNT = 10;

    if (argc >= 2) 
    {
        std::vector<int> Shape = splitStringToInts(argv[1]);
        if (Shape.size()) 
        {
            assert(Shape.size() == 3 && "Invalid shape format: NxLengthxRUN_COUNT\n");
            N = Shape.at(0);
            nodes = Shape.at(1);
            RUN_COUNT = Shape.at(2);
        }
    }

    printf("Data shape %dx%dx%d\n", N, nodes, RUN_COUNT);

    assert(N != 0 && nodes != 0 && "Invalid shape\n");

    double* b = (double*)malloc(nodes * 3 * sizeof(double));
    double* a = (double*)malloc(nodes * 2 * sizeof(double));
    double* input = (double*)malloc(N * sizeof(double));
    double* output = (double*)malloc(N * sizeof(double));

    memset(output, 0, N * sizeof(double));
    // for (int k = 0; k < N; k++) {
    //     input[k] = 1.0;
    // }

    // How to initialize ?
    b[0] = 0.2; b[1] = 0.1; b[2] = 0.1;
    b[3] = 0.3; b[4] = 0.15; b[5] = 0.05;
    b[6] = 0.25; b[7] = 0.2; b[8] = 0.05;

    a[0] = 0.1; a[1] = 0.05; 
    a[2] = 0.2; a[3] = 0.1;
    a[4] = 0.15; a[5] = 0.07;
    
#ifdef CHECK_ACCURACY
    std::string DB = getDB(argv[1]);
    FILE *file = fopen(DB.c_str(), "rb");
    if (file)
    {
        printf("File %s open for read\n", DB.c_str());

        fread(input, sizeof(double), N, file);
    }
    else
    {
#endif
        // Will be used to obtain a seed for the random number engine
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_real_distribution<> dis(-1, 1);
        std::generate(input, input + N, [&]() { return dis(gen); });
#ifdef CHECK_ACCURACY
    }
#endif

#ifdef TRITON_KERNEL_ENABLE

    std::chrono::high_resolution_clock::time_point begin = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < RUN_COUNT; i++)
    {
        iir_kernel_omp();
    }
    std::chrono::high_resolution_clock::time_point end = std::chrono::high_resolution_clock::now();
    std::chrono::milliseconds time_interval = std::chrono::duration_cast<std::chrono::milliseconds>(end - begin);

    PRINT_KERNEL_RUNNING_TIME(TRITON_KERNEL, std::chrono::duration<double>(end - begin).count())

#endif

#ifdef C_KERNEL_ENABLE

    std::chrono::high_resolution_clock::time_point begin_c = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < RUN_COUNT; i++)
    {
        iir(b, a, N, nodes, input, output);
    }
    std::chrono::high_resolution_clock::time_point end_c = std::chrono::high_resolution_clock::now();
    std::chrono::milliseconds time_interval_c = std::chrono::duration_cast<std::chrono::milliseconds>(end_c - begin_c);

    PRINT_KERNEL_RUNNING_TIME(C_KERNEL, std::chrono::duration<double>(end_c - begin_c).count())


#endif

    free(b);
    free(a);
    free(input);
    free(output);

    return 0;
}
