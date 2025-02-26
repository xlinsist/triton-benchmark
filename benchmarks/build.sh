#!/bin/bash

################################################################################
# Set up toolchain environment variables. Make your changes here if you need
################################################################################

PLATFORM="x86"

DIR=`dirname $0`
SRC_DIR=${DIR}/src
BUILD_DIR=${DIR}/build
LLVM_BUILD_DIR=${DIR}/llvm-project/build
AR="${LLVM_BUILD_DIR}/bin/llvm-ar"
AS="${LLVM_BUILD_DIR}/bin/llvm-as"

PYC="python"
TRITON_PLUGIN_DIRS=${DIR}/triton-cpu
KERNEL_LAUNCHER_INCLUDE_DIR=${BUILD_DIR}/aux/include

case $PLATFORM in
    x86)
      CLANGPP="${CLANG_BUILD_DIR}/bin/clang++ -march=native -fvectorize -fslp-vectorize -O3"
      GCC="${GCC_X86_BUILD_DIR}/bin/g++ -march=native -O3"
      OBJDUMP="${GCC_X86_BUILD_DIR}/bin/objdump"
      ;;
    rv)
      CLANGPP="${CLANG_BUILD_DIR}/bin/clang++ --target=riscv64-unknown-linux-gnu \
              --sysroot="${RISCV_GNU_TOOLCHAIN_DIR}/sysroot" \
              --gcc-toolchain="${RISCV_GNU_TOOLCHAIN_DIR}" \
              -fvectorize -fslp-vectorize -O3"
      GCC="${RISCV_GNU_TOOLCHAIN_DIR}/bin/riscv64-unknown-linux-gnu-g++ \
          -march=rv64gcv_zvl256b -mabi=lp64d -O3"
      OBJDUMP="${RISCV_GNU_TOOLCHAIN_DIR}/bin/riscv64-unknown-linux-gnu-objdump"
      ;;
    ?*)
      echo "Unknwon option"
      exit -1
      ;;
esac

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
build_c_kernel_lib() {
  for kernel in ${C_KERNELS[@]}; do
    name=`basename ${kernel} .cpp`
    echo "building c kernel ${kernel}..."
    ${COMPILER} -fPIC -I ${DIR}/include -c ${kernel} -fopenmp -o ${OBJ_DIR}/${name}.o
    ${OBJDUMP} -d ${OBJ_DIR}/${name}.o &> ${OBJ_DIR}/${name}.s
  done

  find ${OBJ_DIR} -not -name "support.o" -name "*.o" | xargs ${AR} rcs ${LIB_DIR}/libkernel.a
}

# build triton kernel
build_triton_kernel_lib() {
  for kernel in ${TRITON_KERNELS[@]}; do
    name=`basename ${kernel} .py`

    KERNEL_AUX_FILE_DIR=${BUILD_DIR}/aux/src/${name}
    mkdir -p ${KERNEL_AUX_FILE_DIR}

    echo "building triton kernel ${kernel}..."
    # compile triton kernel: .py --> .llir + launcher.cpp
    KERNEL_LAUNCHER_INCLUDE_DIR=${KERNEL_LAUNCHER_INCLUDE_DIR} KERNEL_AUX_FILE_DIR=${KERNEL_AUX_FILE_DIR} ${PYC} ${kernel}

    # TODO: Update Clang version
    # For now, we just replace the trunc n[us]w with trunc
    sed -i 's/trunc nuw nsw/trunc/g; s/trunc nuw/trunc/g; s/trunc nsw/trunc/g' ${KERNEL_AUX_FILE_DIR}/*.llir

    # build triton kernel: .llir --> .o
    for kernel_ir in ${KERNEL_AUX_FILE_DIR}/*.llir; do
      kernel_name=`basename ${kernel_ir} .llir`
      ${AS} -o ${OBJ_DIR}/${kernel_name}.bc ${kernel_ir}
      ${COMPILER} -c ${OBJ_DIR}/${kernel_name}.bc -o ${OBJ_DIR}/${kernel_name}.o
      ${OBJDUMP} -d ${OBJ_DIR}/${kernel_name}.o &> ${OBJ_DIR}/${kernel_name}.s
    done

    # build triton laucher: launcher.cpp --> .o
    for kernel_launcher in ${KERNEL_AUX_FILE_DIR}/*.cpp; do
      launcher_name=`basename ${kernel_launcher} .cpp`
      ${COMPILER} \
        -I ${DIR}/include \
        -I ${KERNEL_LAUNCHER_INCLUDE_DIR} \
        -c ${kernel_launcher} \
        -fopenmp \
        -o ${OBJ_DIR}/${launcher_name}.o
      ${OBJDUMP} -d ${OBJ_DIR}/${launcher_name}.o &> ${OBJ_DIR}/${launcher_name}.s
    done
  done

  find ${OBJ_DIR} -not -name "support.o" -name "*.o" | xargs ${AR} rcs ${BUILD_DIR}/lib/triton/libkernel.a
}

create_dir_hierarchy(){
  rm -rf ${LIB_DIR}
  rm -rf ${BIN_DIR}
  rm -rf ${OBJ_DIR}
  mkdir -p ${LIB_DIR}
  mkdir -p ${BIN_DIR}
  mkdir -p ${OBJ_DIR}
  if [ "${PLATFORM}" == "rv" ]; then
    cp  ./openmp-sysroot-riscv/lib/* ${LIB_DIR}
  fi
}

build_driver(){
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
      echo "Unknwon option"
      exit -1
      ;;
  esac

  create_dir_hierarchy
  if [ "${KERNEL_ENABLE}" == "C_KERNEL_ENABLE" ]; then
    build_c_kernel_lib
  else
    mkdir -p ${KERNEL_LAUNCHER_INCLUDE_DIR}
    mkdir -p ${BUILD_DIR}/aux/src
    build_triton_kernel_lib
  fi

  build_support_lib

  # MODE="Accuracy"
  MODE="Benchmark"
  # Benchmark mode don't check accurary since io operation is slow
  if [ "${MODE}" == "Accuracy" ]; then
    COMPILER+=" -DCHECK_ACCURACY "
  fi

  for main in ${DRIVERS[@]}; do
    name=`basename ${main} .cpp`
    echo "generating elf of ${main}..."

    KERNEL_BIN_DIR=${BIN_DIR}/${name}/
    mkdir -p ${KERNEL_BIN_DIR}

    ${COMPILER} \
      "${main}" \
      -I "${DIR}/include" \
      -I "${KERNEL_LAUNCHER_INCLUDE_DIR}" \
      -L "${LIB_DIR}" \
      -fopenmp \
      -lkernel \
      -lsupport \
      -latomic \
      -std=c++17 \
      -D"${KERNEL_ENABLE}" \
      -fPIC \
      -o "${KERNEL_BIN_DIR}/${name}.elf"
    ${OBJDUMP} -d ${KERNEL_BIN_DIR}/${name}.elf &> ${KERNEL_BIN_DIR}/${name}.elf.s
    # Data shape config
    cp ${SRC_DIR}/main/${name}.cfg  ${KERNEL_BIN_DIR}
  done
}

################################################################################
# Main function to build driver. Make your changes here if you need
################################################################################

### FIXME: Choose which kernels should be compiled
# Array of "c_kernel triton_kernel driver_path" entries
drivers=(
  # "${SRC_DIR}/c/correlation.cpp ${SRC_DIR}/triton/correlation.py ${SRC_DIR}/main/correlation.cpp"
  "${SRC_DIR}/c/layernorm.cpp ${SRC_DIR}/triton/layernorm.py ${SRC_DIR}/main/layernorm.cpp"
  # "${SRC_DIR}/c/matmul.cpp ${SRC_DIR}/triton/matmul.py ${SRC_DIR}/main/matmul.cpp"
  # "${SRC_DIR}/c/softmax.cpp ${SRC_DIR}/triton/softmax.py ${SRC_DIR}/main/softmax_kernel.cpp"
  # "${SRC_DIR}/c/rope.cpp ${SRC_DIR}/triton/rope.py ${SRC_DIR}/main/rope.cpp"
  # "${SRC_DIR}/c/dropout.cpp ${SRC_DIR}/triton/dropout.py ${SRC_DIR}/main/dropout.cpp"
  # "${SRC_DIR}/c/resize.cpp ${SRC_DIR}/triton/resize.py ${SRC_DIR}/main/resize.cpp"
  # "${SRC_DIR}/c/warp.cpp ${SRC_DIR}/triton/warp.py ${SRC_DIR}/main/warp.cpp"
)

### FIXME: Choose which kernels should be compiled
C_KERNELS=""
TRITON_KERNELS=""
DRIVERS=""
# Iterate over each entry and build the driver
for entry in "${drivers[@]}"; do
  # Read the three components into variables
  IFS=' ' read -r c_kernel triton_kernel driver_path <<< "$entry"

  # Set environment variables
  C_KERNELS+=" ${c_kernel}"
  TRITON_KERNELS+=" ${triton_kernel}"
  DRIVERS+=" ${driver_path}"
done
echo "C_KERNELS : "${C_KERNELS}
echo "TRITON_KERNELS : "${TRITON_KERNELS}
echo "DRIVERS : "${DRIVERS}

export C_KERNELS
export TRITON_KERNELS
export DRIVERS

echo "building golden using gcc..."
build_driver gcc
echo "build with gcc finished."

echo "building golden using clang..."
build_driver clang
echo "build with clang finished."

echo "building triton..."
# Enable autotuning
# build_driver triton
./autotuning.sh
echo "build with triton finished."
