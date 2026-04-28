# Triton-RV

## NOTE: This repo is now archived. For the latest updates, please see [RuyiAI-Stack/triton-riscv](https://github.com/RuyiAI-Stack/triton-riscv).

## Overview

This repo conducts a comparative analysis of runtime auto-tuning in Triton-CPU across multi-core x86 and RISC-V architectures, benchmarking it against compiler-based auto-tuning approaches to systematically evaluate the impact of various tuning parameters.
1. We introduced cross-platform capabilities to the toolchain, enabling seamless support for both x86 and RISC-V architectures.
2. We developed a visualization module that converts benchmark results into CSV format for streamlined data analysis.
3. We bumped this repo to a Triton-CPU version (2fa1c59), which introduces critical enhancements for CPU performance including Sleef math library integration and optimized multi-threading support.

## Environmental Setup

### **1. Clone and Initialize**

```sh
git clone git@github.com:xlinsist/Triton-RV.git
cd Triton-RV
git submodule update --init
```

### **2. Build triton-cpu**

Build triton-cpu as suggested [here](https://github.com/xlinsist/triton-cpu/).

### **3. Modify global configuration**

modify `global_config.sh` before running. For example, switch `PLATFORM` to `rv` or `x86`.

### **4. Compile, execute, and report the results**

Run the all-in-one script, you may see the generated `report.xls` in the local 'build-<benchmark_name>' directories.
```
cd scripts
./run_all.sh
```
