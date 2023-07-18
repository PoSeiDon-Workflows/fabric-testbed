#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 FABLIB_VERSION"
    exit 1
fi

FABLIB_VERSION=$1
USER_ID=`id -u`
USER_GROUP_ID=`id -g`

docker build \
  --build-arg FABLIB_VERSION=${FABLIB_VERSION} \
  --build-arg FABRIC_USER_ID=${USER_ID} \
  --build-arg FABRIC_USER_GROUP_ID=${USER_GROUP_ID} \
  -t fabric-dev-env:fablib-${FABLIB_VERSION} .
