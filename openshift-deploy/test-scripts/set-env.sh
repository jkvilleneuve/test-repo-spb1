#!/bin/sh
# TODO OPENSHIFT_REGISTRY 172.30.150.232:5000
# TODO DOCKER_REGISTRY 194.67.211.163:5000
# TODO ROUTE_HOST 194.67.211.163

export DOCKER_REGISTRY="docker.io/jkvilleneuve"
export ROUTE_HOST="194.67.210.226"

# temporary hardcoded properties
export PROJECT_NAME="z-test-project"
export MODULE_TAG="1.0.0"

export MODULE_PORT=$(cat ${WORKSPACE}/trunk/${MODULE_NAME}/docker/Dockerfile | awk '/SERVICE_PORT/ {print $3}' 2>/dev/null)
if [ -z "${MODULE_PORT}" ]; then
  export MODULE_PORT=8184
fi

export MODULE_PATH=$(cat ${WORKSPACE}/trunk/${MODULE_NAME}/docker/Dockerfile | awk '/SERVICE_PATH/ {print $3}' 2>/dev/null)
if [ -z "${MODULE_PATH}" ]; then
  export MODULE_PATH="/${PROJECT_NAME}/${MODULE_NAME}/user"
fi
