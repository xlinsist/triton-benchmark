# triton-benchmark
RISCV C and Triton AI-Benchmark. Adapted from https://github.com/Terapines/AI-Benchmark.

## 交叉编译程序到RISC-V上的环境准备

构建riscv-gnu-toolchain，可参考该教程：https://gitee.com/aosp-riscv/working-group/blob/master/articles/20220721-riscv-gcc.md#3-%E7%BC%96%E8%AF%91-risc-v-%E7%9A%84%E4%BA%A4%E5%8F%89%E5%B7%A5%E5%85%B7%E9%93%BE

## 构建步骤（精简版，如原先已成功构建并运行起了triton-cpu）

无需重新构建llvm-project和triton-cpu，只需将triton-cpu的版本回退到38826fcdff（Offload a part of masks optimization to the canonicalizer）即可。此外还要准备一个支持将程序编译到RISC-V上的clang++。如本机没有符合条件的clang++，建议参考下面完整版构建步骤编译llvm得到。

## 构建步骤（完整版，从llvm-project和triton-cpu开始构建）

### 1. Clone and Initialize
```
$ git clone git@github.com:xlinsist/triton-benchmark.git
$ cd triton-benchmark
$ git submodule update --init
```
### 2. Build and Test LLVM/MLIR/CLANG
```
$ cd triton-benchmark
$ cd ./llvm-project  # cloned as submodule
$ mkdir build
$ cd build
$ cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON ../llvm -DLLVM_ENABLE_PROJECTS="clang;mlir;llvm" -DLLVM_TARGETS_TO_BUILD="host;RISCV;NVPTX;AMDGPU"
$ ninja
```
> NOTE: 与triton/triton-cpu中README构建llvm的步骤相比，这里还需要额外增加对clang和RISCV平台的支持，以构建出`build.sh`中用到的CLANGPP。

### 3. Build triton-cpu
```
$ cd ../../triton-cpu # cloned as submodule
$ export LLVM_BUILD_DIR=../llvm-project/build
$ LLVM_INCLUDE_DIRS=$LLVM_BUILD_DIR/include \
         LLVM_LIBRARY_DIR=$LLVM_BUILD_DIR/lib \
         LLVM_SYSPATH=$LLVM_BUILD_DIR \
         pip install -e python
```

## 执行步骤
1. 解压根目录下patch里的压缩包`sysroot.tar.xz`，使得openmp的动态链接库出现的路径为根目录下的"./sysroot/lib/libomp.so"。
2. 在triton-cpu目录下，git apply根目录下的triton-cpu-0001-RISCV.patch。这个patch涉及的重要改动之一是将triton中间文件（特指llir文件）的生成路径从.triton/cache里改到里特定的位置。
3. 修改`build.sh`，`copy_to_remote.sh`，`copy_remote_back.sh`和`report.sh`脚本中带有"Make your changes here !!!"字样的代码部分以适配本地工具链的路径。修改完毕上述四个脚本将可以依次运行。
