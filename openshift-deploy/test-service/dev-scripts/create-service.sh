#!/bin/sh

export MODULE_NAME=test-service
export PROJECT_NAME="z-dev-project"
export BUILD_SCRIPT_DIR=${WORKSPACE}/openshift-deploy/${MODULE_NAME}/dev-scripts

export DOCKER_REGISTRY="docker.io/jkvilleneuve"
export ROUTE_HOST="z-dev-project.apps.oc.ymelnik.ru"

# temporary hardcoded properties
export MODULE_TAG="1"

export MODULE_PORT=8081
export MODULE_PATH="/${MODULE_NAME}/calculate"

echo "name: [${MODULE_NAME}]"

mkdir -v ${BUILD_SCRIPT_DIR}/tmp 2>/dev/null
rm -rf ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.*

for TEMPLATE in $(ls ${BUILD_SCRIPT_DIR}/template); do
  envsubst < ${BUILD_SCRIPT_DIR}/template/$TEMPLATE > ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.$TEMPLATE
done

#WORK_DIR="openshift-deploy"
#ssh root@194.67.211.163 mkdir -v ${WORK_DIR}/dev 2>/dev/null
#ssh root@194.67.211.163 rm -rf ${WORK_DIR}/${MODULE_NAME}.*
#scp ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.* root@194.67.211.163:${WORK_DIR}/dev
#ssh root@194.67.211.163 "cd ${WORK_DIR}/dev;. ${MODULE_NAME}.deploy-module.sh"

#exit