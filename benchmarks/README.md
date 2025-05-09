# triton-benchmark/benchmarks

## Overview

`triton-benchmark/benchmarks` directory analyzes triton-cpu's runtime auto-tuning on multicore CPUs, comparing it with compiler-based auto-tuning to **assess the impact of different tuning parameters**.

This repository is forked from: [https://github.com/Terapines/AI-Benchmark](https://github.com/Terapines/AI-Benchmark). We use clang to compile .llir files generated from triton-cpu.

## Environmental Setup of triton-cpu

### **1. Clone and Initialize**

```sh
$ git clone git@github.com:xlinsist/triton-benchmark.git
$ cd triton-benchmark
$ git submodule update --init
```

### **2. Build LLVM**

```sh
$ cd benchmarks
$ cd ./llvm-project  # cloned as a submodule
$ git checkout 86b69c3 # In compliance with the triton-cpu version we bumped
$ mkdir build
$ cd build
$ cmake -G Ninja ../llvm \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_ENABLE_ASSERTIONS=ON \
        -DLLVM_ENABLE_PROJECTS="mlir;llvm;clang;openmp" \
        -DOPENMP_ENABLE_LIBOMPTARGET=OFF \
        -DLLVM_TARGETS_TO_BUILD="host;NVPTX;AMDGPU"
$ ninja
```

### **3. build SLEEF**

SLEEF is a dependency of triton-cpu. Although documentation of triton-cpu does not mention the need for manual building, this step is essential to avoid runtime issues.

```sh
$ cd benchmarks/
$ cd ./triton-cpu # cloned as a submodule. Since triton-cpu is under development, this is a forked repo
$ git submodule update --init # clone SLEEF as submodule of triton-cpu
$ cd third_party/sleef
$ mkdir build # provided in the SLEEF README for building the project.
$ cmake -S . -B build
$ cmake --build build -j --clean-first
```

### **4. Edit and Build triton-cpu**

```sh
$ cd benchmarks
$ cd ./triton-cpu # cloned as a submodule. Since triton-cpu is under development, this is a forked repo
$ git checkout triton-benchmark # the version of triton-cpu we bumped currently
$ git apply ../patch/triton-cpu-0001-driver.patch
$ git apply ../patch/triton-cpu-0002-autotuning.patch
$ export LLVM_BUILD_DIR=../llvm-project/build
$ LLVM_INCLUDE_DIRS=$LLVM_BUILD_DIR/include \
         LLVM_LIBRARY_DIR=$LLVM_BUILD_DIR/lib \
         LLVM_SYSPATH=$LLVM_BUILD_DIR \
         pip install -e python
```
> WARNING: Currently the patches applied to triton-cpu may have correctness issues that need to be fixed. We are working on it.

## Running on x86

```sh
$ cd benchmarks
$ export CLANG_BUILD_DIR=./llvm-project/build # Since Clang is built along with LLVM, this path can be used directly.
$ export GCC_X86_BUILD_DIR=/usr # By default, the system-installed GCC is used; modify as needed.
$ ./build.sh  # Customize sections marked with "Make your changes here if you need," including method, benchmark, and toolchain paths.
$ ./run.sh
$ ./report.sh
```
Check the `performance_report_overall.csv` generated under `benchmarks` directory.

## Cross-compiling for RISC-V

### **1. Preparing GCC**

To build on a RISC-V platform, the riscv-gnu-toolchain is required. You can download a precompiled package from: [https://archive.spacemit.com/toolchain/](https://archive.spacemit.com/toolchain/).

Set up the environment variable as follows:

```sh
$ export RISCV_GNU_TOOLCHAIN_DIR=<path-to-your-spacemit-toolchain-linux-glibc-x86_64-v1.0.1>
```

### **2. Preparing Clang**

To ensure the Clang version matches the llvm version used by triton-cpu, it is recommended to build it from source.

> **Note:** Please clone a separate `llvm-project` instead of reusing the one that `triton-cpu` depends on. This is because when compiling Clang from source, `-DLLVM_TARGETS_TO_BUILD` must include `RISCV` to support cross-compilation. Recompiling the existing `llvm-project` used by `triton-cpu` may result in runtime errors, such as `LLVMRISCVAsmParser` import failures.

```sh
$ git clone git@github.com:llvm/llvm-project.git
$ mkdir llvm-project/build
$ cd llvm-project/build
$ git checkout 86b69c3 # Ensure it matches the version used by triton-cpu
$ cmake -G Ninja ../llvm \
    -DLLVM_ENABLE_PROJECTS="mlir;clang;openmp" \
    -DLLVM_TARGETS_TO_BUILD="host;RISCV" \
    -DOPENMP_ENABLE_LIBOMPTARGET=OFF \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DCMAKE_BUILD_TYPE=RELEASE
$ ninja check-mlir check-clang
$ export CLANG_BUILD_DIR=<path-to-this-llvm-project>/build # For examples, export CLANG_BUILD_DIR=./llvm-project/build-86b69c-rv
```

### **3. Running on a RISC-V Platform**

First, use `build.sh` to cross-compile and generate ELF files locally. Then, transfer them to a remote RISC-V machine for execution using `run.sh`. Finally, copy the output directory back to the local machine and run `report.sh` to generate performance results.

```sh
$ cd benchmarks
$ ./build.sh --platform rv
$ ./copy_to_remote.sh # Modify REMOTE IP and file paths accordingly.
$ <Use SSH to connect to the REMOTE IP>

// On the remote RISC-V machine:
# <Navigate to the correct directory>
# export LD_LIBRARY_PATH=<path-to-libomp.so>:$LD_LIBRARY_PATH
# ./run.sh
# exit # Exit the remote session

// Back on the local machine:
$ ./copy_remote_back.sh # Modify REMOTE IP and file paths accordingly.
$ ./report.sh
```
Check the `performance_report_overall.csv` generated under `benchmarks` directory.
