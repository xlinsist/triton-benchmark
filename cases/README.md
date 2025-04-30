# triton-benchmark/cases

## Overview

The `triton-benchmark/cases` directory **evaluates both the performance and tuning time** of AI kernels optimized using different tuning frameworks on multi-core CPUs.

## Environmental Setup

### 1. Create and Activate Environment

```sh
cd triton-benchmark/cases
conda create -n <env_name> python=3.10
conda activate <env_name>
pip install -r requirements.txt
```

### 2. Installing Triton-CPU from Source

Triton-CPU is currently experimental and need to be installed from source. To ensure consistent versions, please use the `triton-benchmark` branch of [this forked repo](https://github.com/xlinsist/triton-cpu):
```sh
cd <your-work-dir>
git clone git@github.com:xlinsist/triton-cpu.git
cd triton-cpu
git checkout triton-benchmark
```
Then follow the README to complete the installation.

## Example of Usage

```sh
cd triton-benchmark/cases
cd matmul
python benchmark.py
```
