#!/bin/bash
set -e

# 获取当前脚本的目录
DIR=$(dirname $(readlink -f "$0"))

# 加载全局配置
if [ ! -f "${DIR}/global_config.sh" ]; then    
  echo "Error: global_config.sh not found!"    
  exit 1
fi
source "${DIR}/global_config.sh"

# 将基准测试列表转换为数组
IFS=' ' read -r -a BENCHMARKS <<< "$BENCHMARKS_LIST"
# 根据全局配置加载线程配置
IFS=' ' read -r -a THREADS <<< "$THREADS_LIST"
# 根据启用的编译器设置 COMPILERS 数组
COMPILERS=()
if [ "$ENABLE_GCC" -eq 1 ]; then
  COMPILERS+=("gcc")
fi
if [ "$ENABLE_CLANG" -eq 1 ]; then
  COMPILERS+=("clang")
fi
if [ "$ENABLE_TRITON" -eq 1 ]; then
  COMPILERS+=("triton")
fi

# 遍历每个基准测试
for BENCHMARK in "${BENCHMARKS[@]}"; do
  if [ "$PLATFORM" = "rv" ]; then
    BUILD_DIR="${REMOTE_BASE}/build-${BENCHMARK}"
  else
    BUILD_DIR="${ROOT_DIR}/build-${BENCHMARK}"
  fi
  BIN_DIR="${BUILD_DIR}/bin"
  REPORT_FILE="${BUILD_DIR}/report.xls"

  if [ ! -d "${BIN_DIR}" ]; then
    echo "Warning: ${BIN_DIR} not found, skipping ${BENCHMARK}..."
    continue
  fi

  echo "Generating report: ${REPORT_FILE}..."
  echo -n "" > "${REPORT_FILE}"

  for kernel_name in "${BIN_DIR}/triton/"*/; do
    kernel_name=$(basename "$kernel_name")
    source "${BIN_DIR}/triton/${kernel_name}/${kernel_name}.cfg"

    echo -e "##### ${kernel_name} kernel performance #####" >> "${REPORT_FILE}"
    echo -ne "shape (${SHAPE_DESC})" >> "${REPORT_FILE}"

    # 填写报告的头部
    for THREAD in "${THREADS[@]}"; do
      for COMPILER in "${COMPILERS[@]}"; do
        for kernel in "${BIN_DIR}/${COMPILER}/${kernel_name}/${kernel_name}"*.elf; do
          echo -ne "\t${COMPILER}_T${THREAD}$(basename "$kernel" .elf | sed "s/^${kernel_name}//")" >> "${REPORT_FILE}"
        done
      done
    done
    echo "" >> "${REPORT_FILE}"

    # 填写每种形状的性能数据
    for shape in "${SHAPE[@]}"; do
      echo -ne "${shape}" >> "${REPORT_FILE}"

      for THREAD in "${THREADS[@]}"; do
        for COMPILER in "${COMPILERS[@]}"; do
          kernel_dir="${BIN_DIR}/${COMPILER}/${kernel_name}"
          if [ ! -d "${kernel_dir}" ]; then
            continue
          fi

          for kernel in "${kernel_dir}/${kernel_name}"*.elf; do
            log_file="${kernel_dir}/$(basename "${kernel}" .elf)_T${THREAD}_S${shape}.log"
            second=$(sed -n "s/^.* Kernel Time: \([0-9]\+\(\.[0-9]\+\)*\).*/\1/p" "${log_file}")
            echo -ne "\t${second}" >> "${REPORT_FILE}"
          done
        done
      done
      echo "" >> "${REPORT_FILE}"
    done
    echo "" >> "${REPORT_FILE}"
  done

  echo "Report for ${BENCHMARK} generated."
done

echo "All reports generated in benchmarks' directories."
