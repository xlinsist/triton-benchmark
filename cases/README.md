# triton-benchmark/cases

## Overview

The `triton-benchmark/cases` directory **evaluates both the performance and tuning time** of AI kernels optimized using different tuning frameworks on multi-core CPUs.

## Environmental Setup

### 1. Create and Activate Environment

```sh
conda create -n <env_name> python=3.10
conda activate <env_name>
pip install -r ./cases/requirements.txt
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

Triton-CPU is currently experimental and need to be installed from source. Refer to [the official repo](https://github.com/triton-lang/triton-cpu) for installation. The triton-cpu commit id we use is `2fa1c59`.

## Example of Usage

```sh
cd cases
cd matmul
python benchmark.py
```
