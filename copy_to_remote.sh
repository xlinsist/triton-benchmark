#!/bin/bash

DIR=`dirname $0`

# Make your changes here !!!
REMOTE=zhouxulin@192.168.15.167:/home/zhouxulin/ai-benchmark/

BUILD_DIR=${DIR}/build/

# Make your changes here !!!
ssh zhouxulin@192.168.15.167 "rm -rf /home/zhouxulin/ai-benchmark/bin/*"
scp -r ${BUILD_DIR}/bin ${REMOTE}

scp -r ${DIR}/run.sh ${REMOTE}
