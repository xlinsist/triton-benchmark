# AI-Benchmark

benchmarks目录是是围绕RISCV C和Triton构建的的AI-Benchmark，原仓库来自：https://github.com/Terapines/AI-Benchmark 。这里改用clang来移除掉对zcc的依赖。

## 工具链准备

要交叉编译程序到RISC-V上，需要准备riscv-gnu-toolchain工具链项目。可拉取进迭时空的包：https://archive.spacemit.com/toolchain/。或者参考该教程源码安装：https://gitee.com/aosp-riscv/working-group/blob/master/articles/20220721-riscv-gcc.md#3-%E7%BC%96%E8%AF%91-risc-v-%E7%9A%84%E4%BA%A4%E5%8F%89%E5%B7%A5%E5%85%B7%E9%93%BE

构建完毕后指定环境变量RISCV_GNU_TOOLCHAIN_DIR为install目录以决定gcc的路径，指定环境变量CLANG_BUILD_DIR以决定本地机器中clang的路径，如下面所示。该benchmark会比较gcc和clang的编译性能。
```
export RISCV_GNU_TOOLCHAIN_DIR=/home/buddy-team-share/spacemit-toolchain-linux-glibc-x86_64-v1.0.1
export CLANG_BUILD_DIR=/home/zhouxulin/intern/buddy-mlir/llvm/build
```
> 注意：CLANG_BUILD_DIR的路径不能复用triton-cpu依赖的llvm-project来源码编译得到。因为在源码编译clang时需要在`-DLLVM_TARGETS_TO_BUILD`里加上RISCV，而加上后triton-cpu能编译通过但运行时会有跟LLVMRISCVAsmParser无法import相关的bug。

## 构建步骤

**1. Clone and Initialize**
```
$ git clone git@github.com:xlinsist/triton-benchmark.git
$ cd triton-benchmark
$ git submodule update --init
```
**2. Build and Test LLVM/MLIR**
```
$ cd benchmarks
$ cd ./llvm-project  # cloned as submodule
$ mkdir build
$ cd build
$ cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON ../llvm -DLLVM_ENABLE_PROJECTS="mlir;llvm" -DLLVM_TARGETS_TO_BUILD="host;NVPTX;AMDGPU"
$ ninja
```

**3. Build triton-cpu**
```
$ cd ../..
$ cd ./triton-cpu # cloned as submodule
$ export LLVM_BUILD_DIR=../llvm-project/build
$ LLVM_INCLUDE_DIRS=$LLVM_BUILD_DIR/include \
         LLVM_LIBRARY_DIR=$LLVM_BUILD_DIR/lib \
         LLVM_SYSPATH=$LLVM_BUILD_DIR \
         pip install -e python
```

## 执行步骤
首先，在triton-cpu目录下，git apply根目录下的triton-cpu-0001-RISCV.patch（这个patch涉及的重要改动之一是将triton中间文件的生成路径从.triton/cache里改到里特定的位置）。

然后参考RISC-V平台下的执行步骤（在本地构建出elf文件，随后拷贝到远程RISC-V机器上运行后再拷贝回本地，最后生成性能评测报告）：
```
$ cd benchmarks
$ ./build.sh # 注意修改该文件中的目标平台和工具链路径
$ ./copy_to_remote.sh # 需要修改REMOTE的ip地址和文件路径
$ <用ssh远程登录REMOTE的ip地址>

// 进入到远程环境下
# <cd到REMOTE的路径下>
# export LD_LIBRARY_PATH=<libomp.so所在的某个lib目录>
# ./run.sh
# exit # 退出远程连接

// 回到当前目录
$ ./copy_remote_back.sh # 需要修改REMOTE的ip地址和文件路径
$ ./report.sh # 将性能评测报告保存到"benchmarks/build/report.xls"中
```

X86平台下的执行步骤：
```
$ ./build.sh  # 注意修改该文件中的目标平台和工具链路径
$ cp run.sh ./build
$ cd build
$ export LD_LIBRARY_PATH=<libomp.so所在的某个lib目录> # 比如，export LD_LIBRARY_PATH=/home/zhouxulin/intern/buddy-mlir/llvm/build/lib:$LD_LIBRARY_PATH
$ ./run.sh
$ cd ..
$ ./report.sh
```
