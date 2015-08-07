#!/bin/bash

# Find the directory we exist within
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

: ${NAME:="raintank-metric"}
: ${BUILD_DIR:="${DIR}/build"}
METRIC_DIR="/usr/bin"
METRIC_BUILD_DIR=${BUILD_DIR}${METRIC_DIR}
VERSION="$(${METRIC_BUILD_DIR}/${NAME} -v | cut -f3 -d' ')"
ARCH="$(uname -m)"
PACKAGE_NAME="${DIR}/artifacts/NAME-VERSION-ITERATION_ARCH.deb"
ITERATION=`date +%s`

fpm -s dir -t deb \
  -v ${VERSION} -n ${NAME} -a ${ARCH} --iteration ${ITERATION} --description "Raintank Metric" \
  --deb-upstart ${DIR}/config/ubuntu/trusty/etc/init/raintank-metric \
  -C ${BUILD_DIR} -p ${PACKAGE_NAME} usr etc
