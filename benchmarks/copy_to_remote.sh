#!/bin/bash

DIR=`dirname $0`

# Make your changes here !!!
REMOTE=user@192.168.15.167:/home/user/triton-benchmark/

BUILD_DIR=${DIR}/build/

# Make your changes here !!!
ssh user@192.168.15.167 "rm -rf /home/zhouxulin/ai-benchmark/bin/*"
# scp -r /root/triton/triton-benchmark/benchmarks/openmp-sysroot ${REMOTE}
scp -r ${BUILD_DIR}/bin ${REMOTE}

scp -r ${DIR}/run.sh ${REMOTE}
