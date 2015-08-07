#!/bin/bash

# Find the directory we exist within
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

: ${NAME:="raintank-metric"}
: ${VERSION:=$(npm list | head -1 | awk '{print $1}' | cut -f2 -d@)}
: ${BUILD_DIR:="${DIR}/build"}
METRIC_DIR="/usr/bin"
METRIC_BUILD_DIR=${BUILD_DIR}${METRIC_DIR}

# remove any existing BUILD_DIR
rm -rf ${BUILD_DIR}

mkdir -p ${BUILD_DIR}
mkdir -p ${BUILD_DIR}/etc
mkdir -p ${METRIC_BUILD_DIR}

GOBIN=${METRIC_BUILD_DIR} go get -u github.com/raintank/raintank-metric

cp -fR ${DIR}/config/ubuntu/trusty/etc/raintank ${BUILD_DIR}/etc/
