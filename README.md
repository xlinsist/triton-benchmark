# triton-benchmark

triton-benchmark的benchmarks目录测试了不同的AI算子，在指定了不同线程数时，triton-cpu的运行时调优结果。原仓库来自：https://github.com/Terapines/AI-Benchmark 。这里改用clang来移除掉对zcc的依赖。

## gcc和clang环境准备（可选）

该benchmark会比较gcc和clang跟triton-cpu相比的编译性能，因此需要设置对应的gcc环境变量和clang环境变量。如只关心triton-cpu的性能而不希望测试gcc和clang，也可以在build.sh中带有"Make your changes here if you need"注释的部分手动关闭它们。

### 准备gcc

对于gcc环境变量，如在X86平台上构建，采用本地机器中的gcc来设定即可，一般路径为/usr/bin/gcc，则可设置为：
```
$ export GCC_X86_BUILD_DIR=/usr
```
如在RISC-V平台上构建，需要准备riscv-gnu-toolchain工具链项目中的gcc，可拉取进迭时空的包：https://archive.spacemit.com/toolchain/。
此时设置环境变量如下：
```
$ export RISCV_GNU_TOOLCHAIN_DIR=<path-to-your-spacemit-toolchain-linux-glibc-x86_64-v1.0.1>
```
或者参考该教程源码安装riscv-gnu-toolchain：https://gitee.com/aosp-riscv/working-group/blob/master/articles/20220721-riscv-gcc.md#3-%E7%BC%96%E8%AF%91-risc-v-%E7%9A%84%E4%BA%A4%E5%8F%89%E5%B7%A5%E5%85%B7%E9%93%BE。

### 准备clang

对于clang环境变量CLANG_BUILD_DIR，一般来说采用本地机器中的clang来设定即可，或者从llvm中源码构建：
```
$ git clone git@github.com:llvm/llvm-project.git
$ git checkout 6c59f0e1b0fb
$ mkdir llvm-project/build
$ cd llvm-project/build
$ cmake -G Ninja ../llvm-project \
    -DLLVM_ENABLE_PROJECTS="mlir;clang" \
    -DLLVM_TARGETS_TO_BUILD="host;RISCV" \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DCMAKE_BUILD_TYPE=RELEASE
$ ninja check-mlir check-clang
$ export CLANG_BUILD_DIR=<path-to-this-llvm-project>/build
```
> 注意：CLANG_BUILD_DIR的路径不能复用triton-cpu依赖的llvm-project来源码编译得到。因为在源码编译clang时需要在`-DLLVM_TARGETS_TO_BUILD`里加上RISCV，而加上后triton-cpu虽然能编译通过，但在运行时会报LLVMRISCVAsmParser无法import相关的bug。

## triton-cpu构建

**1. Clone and Initialize**
```
$ git clone git@github.com:xlinsist/triton-benchmark.git
$ cd triton-benchmark
$ git submodule update --init
```
**2. Build LLVM/MLIR**
```
$ cd benchmarks
$ cd ./llvm-project  # cloned as submodule
$ mkdir build
$ cd build
$ cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON ../llvm -DLLVM_ENABLE_PROJECTS="mlir;llvm" -DLLVM_TARGETS_TO_BUILD="host;NVPTX;AMDGPU"
$ ninja
```

**3. Edit and Build triton-cpu**
```
$ cd benchmarks
$ cd ./triton-cpu # cloned as submodule
$ git apply ../triton-cpu-0001-RISCV.patch # to change the path of the .ir files from .triton/cache to a specific location
$ git apply ../triton-cpu-0002-Autotuning.patch
$ export LLVM_BUILD_DIR=../llvm-project/build
$ LLVM_INCLUDE_DIRS=$LLVM_BUILD_DIR/include \
         LLVM_LIBRARY_DIR=$LLVM_BUILD_DIR/lib \
         LLVM_SYSPATH=$LLVM_BUILD_DIR \
         pip install -e python
```

## 执行

### 在X86平台上执行
```
$ cd benchmarks
$ ./build.sh  # 检查和修改该文件中带有"Make your changes here if you need"注释的部分
$ cp run.sh ./build
$ cd build
$ export LD_LIBRARY_PATH=<libomp.so所在的某个lib目录>:$LD_LIBRARY_PATH
$ ./run.sh
$ cd ..
$ ./report.sh
$ python plot_benchmark.py # 将report结果组织成.csv文件并保存在build目录下
```

### 在RISC-V平台上执行

首先将build.sh和autotuning.sh里的Platform变量改为"rv"，采用交叉编译先在本地构建出elf文件，随后拷贝到远程RISC-V机器上运行，最后拷贝回本地生成评测结果。
```
$ cd benchmarks
$ ./build.sh # 注意检查和修改该文件中带有"Make your changes here if you need"注释的部分
$ ./copy_to_remote.sh # 修改REMOTE的ip地址和文件路径
$ <用ssh远程登录REMOTE的ip地址>

// 进入到远程环境下
# <cd到REMOTE的路径下>
# export LD_LIBRARY_PATH=<libomp.so所在的某个lib目录>:$LD_LIBRARY_PATH
# ./run.sh
# exit # 退出远程连接

// 回到当前目录
$ ./copy_remote_back.sh # 修改REMOTE的ip地址和文件路径
$ ./report.sh
$ python plot_benchmark.py # 将report结果组织成.csv文件并保存在build目录下
```

