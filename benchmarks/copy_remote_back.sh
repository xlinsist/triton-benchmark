#!/bin/bash

DIR=`dirname $0`

# Make your changes here !!!
REMOTE=zhouxulin@192.168.15.167:/home/zhouxulin/ai-benchmark/

BUILD_DIR=${DIR}/build/


scp -r ${REMOTE}/bin/ ${BUILD_DIR}/
