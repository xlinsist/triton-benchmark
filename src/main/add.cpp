#ifdef TRITON_KERNEL_ENABLE
#include "add_kernel_launcher.h"
#endif

#include "support/support.h"
#include <vector>
#include <cmath>
#include <iostream>

int main(int argc, char *argv[]) {
  // 1. 默认参数
  int M = 1024;
  int N = 1024;
  int RUN_COUNT = 10;

  // 2. 解析参数 "MxNxRUN_COUNT"
  if (argc >= 2) {
    std::vector<int> Shape = splitStringToInts(argv[1]);
    if (Shape.size() == 3) {
      M = Shape[0];
      N = Shape[1];
      RUN_COUNT = Shape[2];
    } else {
        std::cerr << "Invalid shape format: MxNxRUN_COUNT" << std::endl;
        return -1;
    }
  }

  // 视为一维数组处理
  int n_elements = M * N;
  printf("Add Data shape %dx%d (Total elements: %d), Run count: %d\n", M, N, n_elements, RUN_COUNT);

  // 3. 资源分配与初始化
  std::vector<float> arg0(n_elements);
  std::vector<float> arg1(n_elements);
  std::vector<float> out(n_elements, 0.0f);

  random_init(arg0);
  random_init(arg1);

#ifdef TRITON_KERNEL_ENABLE
  // 4. 定义 Grid
  // TILE_SIZE 是 constexpr，不会出现在参数列表，但通常作为宏定义在头文件中供 grid 计算使用
  int grid_size = std::ceil(1.0 * n_elements / add_kernel_TILE_SIZE);

  // 5. 调用通用 Benchmark
  benchmark_kernel(RUN_COUNT, [&]() {
    add_kernel_omp(
        grid_size, 1, 1,    // gridX, gridY, gridZ
        add_kernel,         // kernel function pointer
        arg0.data(),        // arg0: a_ptr
        arg1.data(),        // arg1: b_ptr
        out.data(),         // arg2: c_ptr
        n_elements,         // arg3: n_elements
        1,                  // arg4: stride_a (连续内存 stride 为 1)
        1,                  // arg5: stride_b
        1                   // arg6: stride_c
    );
  });
#else
  std::cerr << "Triton Kernel Not Enabled!" << std::endl;
#endif

  return 0;
}
