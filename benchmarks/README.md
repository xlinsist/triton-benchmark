# AI-Benchmark

benchmarks目录是是围绕RISCV C和Triton构建的的AI-Benchmark，原仓库来自：https://github.com/Terapines/AI-Benchmark 。这里改用clang来移除掉对zcc的依赖。

## 工具链准备

要交叉编译程序到RISC-V上，需要构建riscv-gnu-toolchain来准备RISC-V工具链，可参考该教程：https://gitee.com/aosp-riscv/working-group/blob/master/articles/20220721-riscv-gcc.md#3-%E7%BC%96%E8%AF%91-risc-v-%E7%9A%84%E4%BA%A4%E5%8F%89%E5%B7%A5%E5%85%B7%E9%93%BE

构建完毕后指定环境变量RISCV_GNU_TOOLCHAIN_DIR为install目录以决定gcc的路径，指定环境变量CLANG_BUILD_DIR以决定本地机器中clang的路径，如下面所示。该benchmark会比较gcc和clang的编译性能。
```
export RISCV_GNU_TOOLCHAIN_DIR=/home/zhouxulin/intern/buddy-mlir/thirdparty/riscv-gnu-toolchain/install
export CLANG_BUILD_DIR=/home/zhouxulin/intern/buddy-mlir/llvm/build
```
> 注意：CLANG_BUILD_DIR的路径不能复用triton-cpu依赖的llvm-project来源码编译得到。因为在源码编译clang时需要在`-DLLVM_TARGETS_TO_BUILD`里加上RISCV，而加上后triton-cpu能编译通过但运行时会有跟LLVMRISCVAsmParser无法import相关的bug。

## 构建步骤（精简版，如原先已成功构建并运行起了triton-cpu）

无需重新构建llvm-project和triton-cpu，只需将triton-cpu的版本回退到38826fcdff（Offload a part of masks optimization to the canonicalizer）即可。此外还要准备一个支持将程序编译到RISC-V上的clang++。

## 构建步骤（完整版，从llvm-project和triton-cpu开始构建）

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
> NOTE: 与triton/triton-cpu中README构建llvm的步骤相比，这里还需要额外增加对clang和RISCV平台的支持，以构建出`build.sh`中用到的CLANGPP。

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

然后运行下面指令，在本地构建出elf文件，随后拷贝到远程RISC-V机器上运行后再拷贝回本地，最后生成性能评测报告。
RISC-V平台下的执行步骤：
```
$ cd benchmarks
$ ./build.sh
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
$ ./build-x86.sh
$ cp run.sh ./build
$ cd build
$ ./run.sh
$ ./report.sh
```
