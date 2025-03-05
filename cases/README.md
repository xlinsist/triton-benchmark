# triton-benchmark/cases

## Overview
The `triton-benchmark/cases` directory evaluates both the performance and search time of AI operators optimized using different tuning frameworks on multi-core CPUs. The evaluated tuning frameworks include Triton, TVM, and Hidet.

## Environment Setup

### 1. Create and Activate Environment
```sh
$ conda create -n <env_name> python=3.10
$ conda activate <env_name>
$ pip install -r ./cases/requirements.txt
```

### 2. Install Hidet and TVM
#### Install Hidet
```sh
pip install hidet # hidet version is 0.5.0
```

#### Install TVM
```sh
pip install apache-tvm --pre # tvm version is 0.14.dev273
```

### 3. Installing Triton-CPU from Source
> **Note:** Triton-CPU is currently experimental and must be installed from source.

You can reuse the Triton-CPU installed in `triton-benchmark/benchmarks` and rerun the following steps (applying the patches is optional):

```sh
$ cd benchmarks
$ cd ./triton-cpu # cloned as submodule
$ git checkout 2fa1c59 # the version that we currently bumped
$ git apply ../patch/triton-cpu-0001-driver.patch # optional
$ git apply ../patch/triton-cpu-0002-autotuning.patch # optional
$ export LLVM_BUILD_DIR=../llvm-project/build
$ LLVM_INCLUDE_DIRS=$LLVM_BUILD_DIR/include \
          LLVM_LIBRARY_DIR=$LLVM_BUILD_DIR/lib \
          LLVM_SYSPATH=$LLVM_BUILD_DIR \
          pip install -e python
```

## Example of Usage
```sh
$ cd cases
$ cd matmul
$ python benchmark.py
```
