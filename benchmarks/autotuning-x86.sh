#!/bin/bash

################################################################################
# Set up toolchain environment variables. Make your changes here if you need
################################################################################

DIR=`dirname $0`
SRC_DIR=${DIR}/src
BUILD_DIR=${DIR}/build
LLVM_BUILD_DIR=${DIR}/llvm-project/build
AR="${LLVM_BUILD_DIR}/bin/llvm-ar"
AS="${LLVM_BUILD_DIR}/bin/llvm-as"

PYC="python"
TRITON_PLUGIN_DIRS=${DIR}/triton-cpu
KERNEL_LAUNCHER_INCLUDE_DIR=${BUILD_DIR}/aux/include

CLANGPP="${CLANG_BUILD_DIR}/bin/clang++ -march=native -fvectorize -fslp-vectorize -O3"
GCC_BUILD_DIR=/usr
GCC="${GCC_BUILD_DIR}/bin/g++ -march=native -O3"
OBJDUMP="${GCC_BUILD_DIR}/bin/objdump"

# Compilation threads
MAX_MULTITHREADING=8

# Default clean build directory
DO_CLEAN="--no-clean"

################################################################################
# User interface. No need to modify code here
################################################################################

# Helper function
help()
{
cat <<END
Build AI-Benchmark.

Usage: ./autotuning.sh [--clean | --no-clean]
                            [--help]

Options:
  --clean | --no-clean
    Should this script clean build dir before building testsuite
    Default: $DO_CLEAN

  --help
    Print this help message and exit
END
}


# Parse command line options
while [ $# -gt 0 ]; do
    case $1 in
        --clean | --no-clean)
            DO_CLEAN=$1
            ;;

        --help | -h)
            help
            exit 0
            ;;

        ?*)
            echo "Invalid options:\"$1\", try $0 --help for help"
            exit 1
            ;;
      esac

      # Process next command-line option
      shift
done

################################################################################
# Core functions for building. No need to modify code here
################################################################################

# build support library
build_support_lib() {
  ${COMPILER} -fPIC -I ${DIR}/include -c ${SRC_DIR}/support/support.cpp -o ${OBJ_DIR}/support.o
  ${OBJDUMP} -d ${OBJ_DIR}/support.o &> ${OBJ_DIR}/support.s
  ${AR} rcs ${LIB_DIR}/libsupport.a ${OBJ_DIR}/support.o
}

create_dir_hierarchy(){
  rm -rf ${LIB_DIR}
  rm -rf ${BIN_DIR}
  rm -rf ${OBJ_DIR}
  mkdir -p ${LIB_DIR}
  mkdir -p ${BIN_DIR}
  mkdir -p ${OBJ_DIR}
}

# build triton kernel
# build_triton_driver + ${ENABLE_AUTOTUNING}
build_triton_driver() {
  echo "building triton kernel ${TRITON_KERNEL}..."
  name=`basename ${TRITON_KERNEL} .py`

  ### FIXME: Modified triton-cpu to generate these files to the BUILD_DIR direcly
  # triton-cpu kernel launcher

  KERNEL_AUX_FILE_DIR=${BUILD_DIR}/aux/src/$1

  mkdir -p ${KERNEL_LAUNCHER_INCLUDE_DIR}
  mkdir -p ${KERNEL_AUX_FILE_DIR}

  # compile triton kernel: .py --> .llir + launcher.cpp
  # TRITON_ALWAYS_COMPILE=1 MLIR_ENABLE_DUMP=1
  ### FIXME: How to specify which kernel to enable among multiple kernels, and whether to enable them simultaneously
  ### Two parameters may be needed to control, one parameter controls ENABLE, and the other parameter controls which ENABLE.
  ENABLE_AUTOTUNING=$1 KERNEL_LAUNCHER_INCLUDE_DIR=${KERNEL_LAUNCHER_INCLUDE_DIR} KERNEL_AUX_FILE_DIR=${KERNEL_AUX_FILE_DIR} ${PYC} ${TRITON_KERNEL}

  driver_name=`basename ${DRIVER} .cpp`

  KERNEL_BIN_DIR=${BIN_DIR}/${driver_name}/
  mkdir -p ${KERNEL_BIN_DIR}

  # Data shape config
  cp ${SRC_DIR}/main/${driver_name}.cfg  ${KERNEL_BIN_DIR}

  # multi-thread
  [ -e /tmp/fd1_hyc ] || mkfifo /tmp/fd1_hyc
  exec 6<>/tmp/fd1_hyc
  rm -rf /tmp/fd1_hyc

  for ((i=1;i<=$MAX_MULTITHREADING;i++))
  do
      echo >&6
  done

  for tunning_dir in ${KERNEL_AUX_FILE_DIR}_*; do
    read -u6
    {

    echo "----------tuning ${tunning_dir}...-------------"
    block_shape=${tunning_dir#*$1_}
    mkdir -p ${OBJ_DIR}/${name}_$1_${block_shape}

    # soft link common kernel llir file
    find "${KERNEL_AUX_FILE_DIR}" -maxdepth 1 -type f -exec ln -s {} "${tunning_dir}" \;

    # TODO: Update Clang version
    # For now, we just replace the trunc n[us]w with trunc
    sed -i 's/trunc nuw nsw/trunc/g; s/trunc nuw/trunc/g; s/trunc nsw/trunc/g' ${tunning_dir}/*.llir

    # build triton kernel: .llir --> .o
    for kernel_ir in ${tunning_dir}/*.llir; do
      kernel_name=`basename ${kernel_ir} .llir`

      ${AS} -o ${KERNEL_AUX_FILE_DIR}_${block_shape}/${kernel_name}.bc ${kernel_ir}
      ${COMPILER} -c ${KERNEL_AUX_FILE_DIR}_${block_shape}/${kernel_name}.bc -o ${OBJ_DIR}/${kernel_name}.o
      ${OBJDUMP} -d ${OBJ_DIR}/${name}_$1_${block_shape}/${kernel_name}.o &> ${KERNEL_AUX_FILE_DIR}_${block_shape}/${kernel_name}.s
      # ${ZCC} -S -x ir ${kernel_ir} -mllvm --riscv-disable-rvv-fixedlen=false -mrvv-vector-bits=256 -o ${KERNEL_AUX_FILE_DIR}_${block_shape}/${kernel_name}.s
      # ${ZCC} -c -o ${OBJ_DIR}/${name}_$1_${block_shape}/${kernel_name}.o ${KERNEL_AUX_FILE_DIR}_${block_shape}/${kernel_name}.s
    done

    # build triton laucher: launcher.cpp --> .o
    for kernel_launcher in ${tunning_dir}/*.cpp; do
      launcher_name=`basename ${kernel_launcher} .cpp`
      ${COMPILER} -I ${DIR}/include -I ${KERNEL_LAUNCHER_INCLUDE_DIR} -c ${kernel_launcher} -fopenmp -o ${OBJ_DIR}/${name}_$1_${block_shape}/${launcher_name}.o
    done

    find ${OBJ_DIR}/${name}_$1_${block_shape}/ -not -name "support.o"  -name "*.o" | xargs ${AR} rcs ${LIB_DIR}/libkernel_$1_${block_shape}.a
    ${AR} rcs ${LIB_DIR}/libkernel_$1_${block_shape}.a ${OBJ_DIR}/$1.o

    # Compile driver
    # .elf suffix to avoid scp problem(same name dir and kernel)
    # Always check accurary
    # echo "${COMPILER} ${DRIVER} -I ${DIR}/include -I ${KERNEL_LAUNCHER_INCLUDE_DIR} -L ${LIB_DIR} -fopenmp -lkernel_$1_${block_shape} -lsupport -latomic -std=c++17 -D${KERNEL_ENABLE} -DCHECK_ACCURACY -fPIC -o ${KERNEL_BIN_DIR}/${driver_name}_$1_${block_shape}.elf"
    ${COMPILER} ${DRIVER} -I ${DIR}/include -I ${KERNEL_LAUNCHER_INCLUDE_DIR} -L ${LIB_DIR} -fopenmp -lkernel_$1_${block_shape} -lsupport -latomic -std=c++17 -D${KERNEL_ENABLE} -DCHECK_ACCURACY -fPIC -o ${KERNEL_BIN_DIR}/${driver_name}_$1_${block_shape}.elf
    ${OBJDUMP} -d ${KERNEL_BIN_DIR}/${driver_name}_$1_${block_shape}.elf &> ${KERNEL_BIN_DIR}/${driver_name}_$1_${block_shape}.elf.s

      echo >&6
    } &
  done
  wait
  exec 6>&-
}

################################################################################
# Main function to build driver. Make your changes here if you need
################################################################################

### FIXME: Choose which kernels should be compiled
# FIXME: Use config

# Array of "kernel_path driver_path tunning_arg" entries
drivers=(
  # "triton/layernorm.py main/layernorm.cpp _layer_norm_fwd_fused"
  # "triton/layernorm.py main/layernorm.cpp _layer_norm_bwd_fused"
  "triton/correlation.py main/correlation.cpp correlation_kernel"
  # "triton/softmax.py main/softmax_kernel.cpp softmax_kernel"
  # "triton/matmul.py main/matmul.cpp matmul_kernel"
  # "triton/rope.py main/rope.cpp rope_kernel"
  # "triton/dropout.py main/dropout.cpp dropout_kernel"
  # "triton/resize.py main/resize.cpp resize_kernel"
  # "triton/warp.py main/warp.cpp warp_kernel"
)

### TODO: Options for build function
# 1. build
# 2. copy shape config

# build triton driver
COMPILER=${CLANGPP}
LIB_DIR=${BUILD_DIR}/lib/triton
BIN_DIR=${BUILD_DIR}/bin/triton
OBJ_DIR=${BUILD_DIR}/obj/triton
KERNEL_ENABLE=TRITON_KERNEL_ENABLE

if [ "x$DO_CLEAN" = "x--clean" ]; then
    echo "Cleaning triton build directories"
    rm -rf $BIN_DIR
    rm -rf $LIB_DIR
    rm -rf $OBJ_DIR
    rm -rf ${BUILD_DIR}/aux/
fi

create_dir_hierarchy
mkdir -p ${BUILD_DIR}/aux/src

build_support_lib

# Iterate over each entry and build the driver
for entry in "${drivers[@]}"; do
  # Read the three components into variables
  IFS=' ' read -r kernel_path driver_path tunning_arg <<< "$entry"

  # Set environment variables
  TRITON_KERNEL="${SRC_DIR}/${kernel_path}"
  DRIVER="${SRC_DIR}/${driver_path}"

  # Optionally export them if build_triton_driver requires
  export TRITON_KERNEL
  export DRIVER

  # Call the build function with the specified argument
  build_triton_driver "$tunning_arg"

  # Unset variables if they shouldn't persist
  unset TRITON_KERNEL
  unset DRIVER
done
