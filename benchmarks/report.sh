#!/bin/bash

# MODE="Accuracy"
MODE="Benchmark"

# DIR=`dirname $0`/build-rv
DIR=`dirname $0`

# BENCHMARKS=("matmul" "softmax" "correlation" "layernorm"  "dropout" "rope" "resize")
BENCHMARKS=("softmax")

for BENCHMARK in "${BENCHMARKS[@]}"; do
  BUILD_DIR="${DIR}/build-${BENCHMARK}"
  BIN_DIR="${BUILD_DIR}/bin"
  REPORT_FILE="${BUILD_DIR}/report.xls"

  if [ ! -d "${BIN_DIR}" ]; then
    echo "Warning: ${BIN_DIR} not found, skipping ${BENCHMARK}..."
    continue
  fi

  echo "Report performace to ${REPORT_FILE}..."

  # Keyword to extract the kernel running time
  # STAT_KEYWORD=(C Triton)

  COMPILER=(clang triton)
  THREADS=(1 4 8)

  TRITON_KERNELS=`ls ${BIN_DIR}/triton/`
  # TRITON_KERNELS=layernorm

  echo -n "" > ${REPORT_FILE}
  # Kernel performance on different shape
  for kernel_name in ${TRITON_KERNELS}; do
    echo "${kernel_name}"
    # header
    # shape array
    # NOTE: get from config
    source ${BIN_DIR}/triton/${kernel_name}/${kernel_name}.cfg
    echo ${SHAPE[*]}
    echo -e "##### ${kernel_name} kernel performance #####" >> ${REPORT_FILE}

    echo -ne "shape (${SHAPE_DESC})" >> ${REPORT_FILE}
    for thread in ${THREADS[@]}; do
      for compiler in ${COMPILER[@]}; do
        for kernel in `ls -v ${BIN_DIR}/${compiler}/${kernel_name}/${kernel_name}*.elf`; do
          tmp=`basename ${kernel} .elf`
          block_shape=${tmp#${kernel_name}*}
          echo -ne "\t${compiler}_T${thread}${block_shape}" >> ${REPORT_FILE}
        done
      done
    done
    echo "" >> ${REPORT_FILE}

    # average_percentage=0.0
    for shape in ${SHAPE[@]}; do
      echo -ne "${shape}" >> ${REPORT_FILE}

      for thread in ${THREADS[@]}; do
        for compiler in ${COMPILER[@]}; do
          ### FIXME: Check whether is a kernel directory
          kernel_dir=${BIN_DIR}/${compiler}/${kernel_name}
          if [ ! -d "${kernel_dir}" ];then
              continue
          fi

          #=================================================#
          # NOTE: depend on the format of perf.log
          # extract the statistics

          # percentage=1.0
          for kernel in `ls -v ${kernel_dir}/${kernel_name}*.elf`; do
            tmp=`basename ${kernel} .elf`

            second=$(cat ${kernel_dir}/${tmp}_T${thread}_S${shape}.log | sed -n "s/^.* Kernel Time: \([0-9]\+\(\.[0-9]\+\)*\).*/\1/p")
            # percentage=$(echo "scale=2; ${second} / ${percentage}" | bc)

            echo "read from ${kernel_dir}/${tmp}_T${thread}_S${shape}.log, get time ${second} s."
            echo -ne "\t${second}" >> ${REPORT_FILE}
          done
        done
        #=================================================#

        # calculate the performance gap percentage
        # echo -ne "\t${percentage}" >> ${REPORT_FILE}

        # Accumulate performance gap percentage
        # average_percentage=$(echo "${average_percentage} + ${percentage}" | bc)
      done
      echo "" >> ${REPORT_FILE}

    done
    echo "" >> ${REPORT_FILE}
    # Average performance gap percentage
    # average_percentage=$(echo "scale=2; ${average_percentage}/${#SHAPE[@]} " | bc)

    # tabs=$(printf '\t%.0s' $(seq 1 ${#STAT_KEYWORD[@]}))
    # echo -e "average percentage\t${tabs}${average_percentage}" >> ${REPORT_FILE}

    echo "" >> ${REPORT_FILE}
    echo "" >> ${REPORT_FILE}
  done

  echo "" >> ${REPORT_FILE}
  echo "" >> ${REPORT_FILE}
done

python ./get_data.py
