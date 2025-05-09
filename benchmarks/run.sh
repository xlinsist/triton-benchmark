#!/bin/bash

# MODE="Accuracy"
MODE="Benchmark"

DIR=`dirname $0`

# BENCHMARKS=("matmul" "softmax" "correlation" "layernorm"  "dropout" "rope" "resize")
BENCHMARKS=("softmax")

for BENCHMARK in "${BENCHMARKS[@]}"; do

  BUILD_DIR="${DIR}/build-${BENCHMARK}"
  BIN_DIR=${BUILD_DIR}/bin/

  THREAD=(1 4 8)

  # COMPILER=(triton gcc clang)
  COMPILER=(clang triton)

  for compiler in ${COMPILER[@]}; do
    for f_sub in `ls ${BIN_DIR}/${compiler}`; do
      ### FIXME: Check whether is a kernel directory
      kernel_dir=${BIN_DIR}/${compiler}/${f_sub}
      echo "${kernel_dir}"
      if [ ! -d "${kernel_dir}" ];then
          continue
      fi

      kernel_name=`basename ${f_sub}`
      echo ${kernel_name}

      # shape array
      # NOTE: get from config
      source ${kernel_dir}/${kernel_name}.cfg

      for thread in ${THREAD[@]}; do
        for shape in ${SHAPE[@]}; do
          for kernel in `ls -v ${kernel_dir}/${kernel_name}*.elf`; do
            echo ${kernel}
            tmp=`basename ${kernel} .elf`
            block_shape=${tmp#*_}
            DB_FILE=${BUILD_DIR}/${kernel_name} TRITON_CPU_MAX_THREADS=${thread} bash -c "${kernel} ${shape}" 2> "${kernel_dir}/${tmp}_T${thread}_S${shape}.log"

          done
        done
      done

    done
  done
done
