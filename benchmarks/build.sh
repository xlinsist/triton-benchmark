#!/bin/bash
################################################################################
# User interface. No need to modify code here
################################################################################

# Helper function
help()
{
cat <<END
Build Triton-Benchmark.

Usage: ./build.sh [--clean | --no-clean]
                  [--help]
                  [--platform x86 | rv]

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

        --platform)
            PLATFORM=$2
            shift
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
  echo "building support lib..."
  ${COMPILER} -fPIC -I ${DIR}/include -c ${SRC_DIR}/support/support.cpp -o ${OBJ_DIR}/support.o
  ${OBJDUMP} -d ${OBJ_DIR}/support.o &> ${OBJ_DIR}/support.s
  ${AR} rcs ${LIB_DIR}/libsupport.a ${OBJ_DIR}/support.o
}

# build c kernel
build_c_kernel_lib_and_driver() {
  name=`basename ${C_KERNEL} .cpp`
  echo "building c kernel ${C_KERNEL}..."
  ${COMPILER} -fPIC -I ${DIR}/include -c ${C_KERNEL} -fopenmp -o ${OBJ_DIR}/${name}.o
  ${OBJDUMP} -d ${OBJ_DIR}/${name}.o &> ${OBJ_DIR}/${name}.s

  find ${OBJ_DIR} -not -name "support.o" -name "*.o" | xargs ${AR} rcs ${LIB_DIR}/libkernel.a

  name=`basename ${DRIVER} .cpp`
  echo "generating elf of ${DRIVER}..."

  KERNEL_BIN_DIR=${BIN_DIR}/${name}/
  mkdir -p ${KERNEL_BIN_DIR}

  ${COMPILER} \
    "${DRIVER}" \
    -I "${DIR}/include" \
    -I "${KERNEL_LAUNCHER_INCLUDE_DIR}" \
    -L "${LIB_DIR}" \
    -fopenmp \
    -lkernel \
    -lsupport \
    -latomic \
    -std=c++17 \
    -L${CLANG_BUILD_DIR}/lib \
    -D"${KERNEL_ENABLE}" \
    -fPIC \
    -o "${KERNEL_BIN_DIR}/${name}.elf"
  ${OBJDUMP} -d ${KERNEL_BIN_DIR}/${name}.elf &> ${KERNEL_BIN_DIR}/${name}.elf.s
  # Data shape config
  cp ${SRC_DIR}/main/${name}.cfg  ${KERNEL_BIN_DIR}
}

# build triton kernel
build_triton_kernel_lib_and_driver() {
  echo "building triton kernel ${TRITON_KERNEL}..."
  name=`basename ${TRITON_KERNEL} .py`

  ### FIXME: Modified triton-cpu to generate these files to the BUILD_DIR direcly
  # triton-cpu kernel launcher

  KERNEL_AUX_FILE_DIR=${BUILD_DIR}/aux/src/${TUNNING_ARG}

  mkdir -p ${KERNEL_LAUNCHER_INCLUDE_DIR}
  mkdir -p ${KERNEL_AUX_FILE_DIR}

  # compile triton kernel: .py --> .llir + launcher.cpp
  # TRITON_ALWAYS_COMPILE=1 MLIR_ENABLE_DUMP=1
  ### FIXME: How to specify which kernel to enable among multiple kernels, and whether to enable them simultaneously
  ### Two parameters may be needed to control, one parameter controls ENABLE, and the other parameter controls which ENABLE.
  ENABLE_AUTOTUNING=${TUNNING_ARG} KERNEL_LAUNCHER_INCLUDE_DIR=${KERNEL_LAUNCHER_INCLUDE_DIR} KERNEL_AUX_FILE_DIR=${KERNEL_AUX_FILE_DIR} ${PYC} ${TRITON_KERNEL}
  # echo "ENABLE_AUTOTUNING=${TUNNING_ARG} KERNEL_LAUNCHER_INCLUDE_DIR=${KERNEL_LAUNCHER_INCLUDE_DIR} KERNEL_AUX_FILE_DIR=${KERNEL_AUX_FILE_DIR} ${PYC} ${TRITON_KERNEL}"

  driver_name=`basename ${DRIVER} .cpp`

  KERNEL_BIN_DIR=${BIN_DIR}/${driver_name}
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
    block_shape=${tunning_dir#*${TUNNING_ARG}_}
    mkdir -p ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}

    # TODO: Check if we need to soft link common kernel llir file. If not, remove this line
    # find "${KERNEL_AUX_FILE_DIR}" -maxdepth 1 -type f -exec ln -s {} "${tunning_dir}" \;

    # For now, we just replace the trunc n[us]w with trunc
    sed -i 's/trunc nuw nsw/trunc/g; s/trunc nuw/trunc/g; s/trunc nsw/trunc/g' ${tunning_dir}/*.llir

    # build triton kernel: .llir --> .o
    for kernel_ir in ${tunning_dir}/*.llir; do
      kernel_name=`basename ${kernel_ir} .llir`

      ${AS} -o ${KERNEL_AUX_FILE_DIR}_${block_shape}/${kernel_name}.bc ${kernel_ir}
      ${COMPILER} -c ${KERNEL_AUX_FILE_DIR}_${block_shape}/${kernel_name}.bc -o ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/${kernel_name}.o
      ${OBJDUMP} -d ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/${kernel_name}.o &> ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/${kernel_name}.s
    done

    # build triton laucher: launcher.cpp --> .o
    for kernel_launcher in ${tunning_dir}/*.cpp; do
      launcher_name=`basename ${kernel_launcher} .cpp`
      ${COMPILER} -I ${DIR}/include -I ${KERNEL_LAUNCHER_INCLUDE_DIR} -c ${kernel_launcher} -fopenmp -o ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/${launcher_name}.o
      ${OBJDUMP} -d ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/${launcher_name}.o &> ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/${launcher_name}.s
    done

    find ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/ -not -name "support.o"  -name "*.o" | xargs ${AR} rcs ${LIB_DIR}/libkernel_${TUNNING_ARG}_${block_shape}.a
    ${AR} rcs ${LIB_DIR}/libkernel_${TUNNING_ARG}_${block_shape}.a ${OBJ_DIR}/${name}_${TUNNING_ARG}_${block_shape}/${kernel_name}.o
    
    # Compile driver
    # .elf suffix to avoid scp problem(same name dir and kernel)
    ${COMPILER} ${DRIVER} -I ${DIR}/include -I ${KERNEL_LAUNCHER_INCLUDE_DIR} \
        -L ${LIB_DIR} -fopenmp -L${CLANG_BUILD_DIR}/lib \
        -lkernel_${TUNNING_ARG}_${block_shape} -lsupport -latomic \
        -std=c++17 -D${KERNEL_ENABLE} -fPIC \
        -o ${KERNEL_BIN_DIR}/${driver_name}_${TUNNING_ARG}_${block_shape}.elf

    ${OBJDUMP} -d ${KERNEL_BIN_DIR}/${driver_name}_${TUNNING_ARG}_${block_shape}.elf &> ${KERNEL_BIN_DIR}/${driver_name}_${TUNNING_ARG}_${block_shape}.elf.s

      echo >&6
    } &
  done
  wait
  exec 6>&-
}

create_dir_hierarchy(){
  mkdir -p ${LIB_DIR}
  mkdir -p ${BIN_DIR}
  mkdir -p ${OBJ_DIR}
  if [ "${PLATFORM}" == "rv" ]; then
    cp  ./openmp-sysroot-riscv/lib/* ${LIB_DIR}
  fi
}

build_driver() {
  if [ $# -ne 2 ]; then
    echo "Usage: build_driver <compiler> <benchmark>"
    exit 1
  fi

  case $1 in
    gcc)
      COMPILER=${GCC}
      LIB_DIR=${BUILD_DIR}/lib/gcc
      BIN_DIR=${BUILD_DIR}/bin/gcc
      OBJ_DIR=${BUILD_DIR}/obj/gcc
      KERNEL_ENABLE=C_KERNEL_ENABLE
      ;;
    clang)
      COMPILER=${CLANGPP}
      LIB_DIR=${BUILD_DIR}/lib/clang
      BIN_DIR=${BUILD_DIR}/bin/clang
      OBJ_DIR=${BUILD_DIR}/obj/clang
      KERNEL_ENABLE=C_KERNEL_ENABLE
      ;;
    triton)
      COMPILER=${CLANGPP}
      LIB_DIR=${BUILD_DIR}/lib/triton
      BIN_DIR=${BUILD_DIR}/bin/triton
      OBJ_DIR=${BUILD_DIR}/obj/triton
      KERNEL_ENABLE=TRITON_KERNEL_ENABLE
      ;;
    ?*)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac

  # Clean build directories if needed
  if [ "x$DO_CLEAN" = "x--clean" ]; then
    echo "Cleaning triton build directories"
    rm -rf $BIN_DIR
    rm -rf $LIB_DIR
    rm -rf $OBJ_DIR
    if [ "${KERNEL_ENABLE}" == "TRITON_KERNEL_ENABLE" ]; then
      rm -rf ${BUILD_DIR}/aux/
    fi
  fi

  create_dir_hierarchy
  if [ "${KERNEL_ENABLE}" == "C_KERNEL_ENABLE" ]; then
    :
  else
    mkdir -p ${KERNEL_LAUNCHER_INCLUDE_DIR}
    mkdir -p ${BUILD_DIR}/aux/src
  fi

  build_support_lib

  # MODE="Accuracy"
  MODE="Benchmark"
  # Benchmark mode doesn't check accuracy since IO operation is slow
  if [ "${MODE}" == "Accuracy" ]; then
    COMPILER+=" -DCHECK_ACCURACY "
  fi

  if [ "${KERNEL_ENABLE}" == "C_KERNEL_ENABLE" ]; then
    build_c_kernel_lib_and_driver
  else
    echo "Building Triton kernel and driver with benchmark: $2"
    build_triton_kernel_lib_and_driver "$2"
  fi
}

################################################################################
# Set up toolchain environment variables. Make your changes here if you need
################################################################################

# Compilation threads
MAX_MULTITHREADING=8

DIR=`dirname $0`
SRC_DIR=${DIR}/src
LLVM_BUILD_DIR=${DIR}/llvm-project/build
AR="${LLVM_BUILD_DIR}/bin/llvm-ar"
AS="${LLVM_BUILD_DIR}/bin/llvm-as"

PYC="python"
TRITON_PLUGIN_DIRS=${DIR}/triton-cpu

# Default platform
if [ -z "$PLATFORM" ]; then
  PLATFORM="x86"
fi
if [ -z "$GCC_X86_BUILD_DIR" ]; then
  GCC_X86_BUILD_DIR=/usr
fi
if [ -z "$CLANG_BUILD_DIR" ]; then
  CLANG_BUILD_DIR=${LLVM_BUILD_DIR}
fi

# Default clean build directory
if [ -z "$DO_CLEAN" ]; then
  DO_CLEAN="--no-clean"
fi

case $PLATFORM in
    x86)
      CLANGPP="${CLANG_BUILD_DIR}/bin/clang++ -march=native -fvectorize -fslp-vectorize -O3 -std=c++17"
      GCC="${GCC_X86_BUILD_DIR}/bin/g++ -march=native -O3 -std=c++17"
      OBJDUMP="${GCC_X86_BUILD_DIR}/bin/objdump"
      ;;
    rv)
      CLANGPP="${CLANG_BUILD_DIR}/bin/clang++ --target=riscv64-unknown-linux-gnu \
              --sysroot="${RISCV_GNU_TOOLCHAIN_DIR}/sysroot" \
              --gcc-toolchain="${RISCV_GNU_TOOLCHAIN_DIR}" \
              -fvectorize -fslp-vectorize -O3 -std=c++17"
      GCC="${RISCV_GNU_TOOLCHAIN_DIR}/bin/riscv64-unknown-linux-gnu-g++ \
          -march=rv64gcv_zvl256b -mabi=lp64d -O3 -std=c++17"
      OBJDUMP="${RISCV_GNU_TOOLCHAIN_DIR}/bin/riscv64-unknown-linux-gnu-objdump"
      ;;
    ?*)
      echo "Unknwon option"
      exit -1
      ;;
esac

#!/bin/bash

################################################################################
# Main function to build driver. Make your changes here if you need
################################################################################

# BENCHMARKS=("matmul" "softmax" "correlation" "layernorm"  "dropout" "rope" "resize")
BENCHMARKS=("softmax")

for BENCHMARK in "${BENCHMARKS[@]}"; do
  # Array of "c_kernel triton_kernel driver_path tuning_arg" entries
  case "$BENCHMARK" in
    "matmul")
      drivers=(
        "${SRC_DIR}/c/matmul.cpp ${SRC_DIR}/triton/matmul.py ${SRC_DIR}/main/matmul.cpp matmul_kernel"
      )
      ;;
    "softmax")
      drivers=(
        "${SRC_DIR}/c/softmax.cpp ${SRC_DIR}/triton/softmax.py ${SRC_DIR}/main/softmax.cpp softmax_kernel"
      )
      ;;
    "layernorm")
      drivers=(
        "${SRC_DIR}/c/layernorm.cpp ${SRC_DIR}/triton/layernorm.py ${SRC_DIR}/main/layernorm.cpp _layer_norm_fwd_fused"
      )
      ;;
    "correlation")
      drivers=(
        "${SRC_DIR}/c/correlation.cpp ${SRC_DIR}/triton/correlation.py ${SRC_DIR}/main/correlation.cpp correlation_kernel"
      )
      ;;
    "dropout")
      drivers=(
        "${SRC_DIR}/c/dropout.cpp ${SRC_DIR}/triton/dropout.py ${SRC_DIR}/main/dropout.cpp dropout_kernel"
      )
      ;;
    "resize")
      drivers=(
        "${SRC_DIR}/c/resize.cpp ${SRC_DIR}/triton/resize.py ${SRC_DIR}/main/resize.cpp resize_kernel"
      )
      ;;
    "rope")
      drivers=(
        "${SRC_DIR}/c/rope.cpp ${SRC_DIR}/triton/rope.py ${SRC_DIR}/main/rope.cpp rope_kernel"
      )
      ;;
    "warp")
      drivers=(
        "${SRC_DIR}/c/warp.cpp ${SRC_DIR}/triton/warp.py ${SRC_DIR}/main/warp.cpp warp_kernel"
      )
      ;;
    *)
      echo "Unknown benchmark: $BENCHMARK"
      continue
      ;;
  esac

  if [[ ${#drivers[@]} -eq 0 ]]; then
    echo "No valid drivers for $BENCHMARK, skipping..."
    continue
  fi

  BUILD_DIR="${DIR}/build-${BENCHMARK}"
  KERNEL_LAUNCHER_INCLUDE_DIR="${BUILD_DIR}/aux/include"

  for entry in "${drivers[@]}"; do
    IFS=' ' read -r c_kernel triton_kernel driver_path tuning_arg <<< "$entry"

    export C_KERNEL="${c_kernel}"
    export TRITON_KERNEL="${triton_kernel}"
    export DRIVER="${driver_path}"
    export TUNNING_ARG="${tuning_arg}"

    echo "C_KERNEL : ${C_KERNEL}"
    echo "TRITON_KERNEL : ${TRITON_KERNEL}"
    echo "DRIVER : ${DRIVER}"
    echo "TUNNING_ARG : ${TUNNING_ARG}"

    # echo "building golden using gcc..."
    # build_driver gcc $BENCHMARK
    # echo "build with gcc finished."

    echo "building golden using clang..."
    build_driver clang $BENCHMARK
    echo "build with clang finished."

    echo "building triton..."
    build_driver triton $BENCHMARK
    echo "build with triton finished."

    unset C_KERNEL
    unset TRITON_KERNEL
    unset DRIVER
    unset TUNNING_ARG
  done
done
