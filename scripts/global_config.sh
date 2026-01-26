#!/bin/bash

# ==============================================================================
#                            Global Build Configuration
#
# This file centralizes all user-specific settings for the Triton benchmark suite.
# Modify the variables in this file to configure the build and run process.
# ==============================================================================


# ==========================================
# 1. Core Build Switches
# ==========================================
# Set to 1 to enable, 0 to disable compilation with a specific toolchain.
# The `run.sh` and `copy_to_remote.sh` scripts will use these flags
# to determine which subdirectories (e.g., 'gcc', 'clang', 'triton') to process.
export ENABLE_GCC=0
export ENABLE_CLANG=0
export ENABLE_TRITON=1

# Default clean behavior for the build script.
# Can be overridden with command-line flags (--clean or --no-clean).
export DEFAULT_DO_CLEAN="--clean"

# ==========================================
# 2. Target Platform and Remote Execution
# ==========================================
# Target platform: "x86" or "rv" (for RISC-V).
export PLATFORM="rv"

# Remote machine configuration for running RISC-V benchmarks.
# Ensure you have passwordless SSH access to this machine.
REMOTE_URL="user@192.168.15.167"
# REMOTE_URL="user@192.168.15.175"
REMOTE_BASE="/home/user/triton-benchmark/build-rv"

# Scripts to be copied to the remote machine for execution.
export SCRIPTS_TO_COPY="execute.sh report.sh global_config.sh"

# ==========================================
# 3. Concurrency and Benchmark Selection
# ==========================================
# Number of parallel threads for compilation.
export MAX_MULTITHREADING=8

# Space-separated list of thread counts to use for running benchmarks.
# Example: "1 2 4 8"
export THREADS_LIST="1"

# Space-separated list of benchmarks to build and run.
# Example: "add matmul softmax layernorm correlation dropout resize rope warp"
# export BENCHMARKS_LIST="matmul softmax layernorm correlation dropout resize rope warp"
export BENCHMARKS_LIST="add"

export MODE="Benchmark" # Or "Validation", "Test", etc.


# ==========================================
# 4. Paths and Directories
# ==========================================
# Base directory of the benchmark suite.
DIR_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
export ROOT_DIR="$(dirname "${DIR_PATH}")"
export SRC_DIR="${ROOT_DIR}/src"
export INCLUDE_DIR="${ROOT_DIR}/include"
export THIRD_PARTY_DIR="${ROOT_DIR}/thirdparty"

# Python executable for generating Triton kernels.
export PYTHON_EXECUTABLE="python"
export TRITON_PLUGIN_DIRS="${THIRD_PARTY_DIR}/triton-cpu"

# LLVM and toolchain paths.
export LLVM_BUILD_DIR="${THIRD_PARTY_DIR}/llvm-project/build-86b69c3-rv-clang"
if [ "$PLATFORM" = "rv" ]; then
  # RISC-V toolchain paths
  export CLANG_BUILD_DIR="${THIRD_PARTY_DIR}/llvm-project/build-86b69c3-rv-clang"
  export OPENMP_LIB_DIR="${THIRD_PARTY_DIR}/openmp-sysroot-riscv"
  export RISCV_GNU_TOOLCHAIN_DIR="${THIRD_PARTY_DIR}/spacemit-toolchain-linux-glibc-x86_64-v1.0.1"
else
  # x86 toolchain paths
  export CLANG_BUILD_DIR="${THIRD_PARTY_DIR}/llvm-project/build-86b69c3"
  export OPENMP_LIB_DIR="${CLANG_BUILD_DIR}/lib"
  export GCC_X86_BUILD_DIR="/usr"
fi

# ==========================================
# 5. Compiler Flags (Advanced)
# ==========================================
# Common C++ standard.
export CPP_STD="-std=c++17"

# Optimization flags for x86.
export X86_FLAGS="-march=native -fvectorize -fslp-vectorize -O3"

# Optimization flags for RISC-V.
export RV_FLAGS="-march=rv64gcv -fvectorize -fslp-vectorize -O3"
export RV_GCC_FLAGS="-march=rv64gcv_zvl256b -mabi=lp64d -O3"
