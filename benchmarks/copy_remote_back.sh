#!/bin/bash

DIR=`dirname $0`
REMOTE_URL="user@192.168.15.167" # 根据远程平台做修改

# BENCHMARKS=("matmul" "softmax" "correlation" "layernorm"  "dropout" "rope" "resize")
BENCHMARKS=("softmax")

for BENCHMARK in "${BENCHMARKS[@]}"; do
    REMOTE_BASE="/home/user/triton-benchmark/build-rv/build-${BENCHMARK}/bin" # 根据远程平台做修改
    REMOTE="${REMOTE_URL}:${REMOTE_BASE}"

    BUILD_DIR=${DIR}/build-${BENCHMARK}/

    scp -r ${REMOTE} ${BUILD_DIR}
done
