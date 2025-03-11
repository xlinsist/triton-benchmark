#!/bin/bash

DIR=`dirname $0`

# Make your changes here !!!
REMOTE=user@192.168.15.167:/home/user/triton-benchmark/

# Make your changes here !!!
BUILD_DIR=${DIR}/build-matmul/


scp -r ${REMOTE}/bin/ ${BUILD_DIR}/
