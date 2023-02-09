#!/usr/bin/env bash

FABLIB_VERSION=1.4.0
USER_ID=`id -u`
USER_GROUP_ID=`id -g`

docker build \
  --build-arg FABLIB_VERSION=${FABLIB_VERSION} \
  --build-arg FABRIC_USER_ID=${USER_ID} \
  --build-arg FABRIC_USER_GROUP_ID=${USER_GROUP_ID} \
  -t fabric-dev-env:fablib-${FABLIB_VERSION} .
