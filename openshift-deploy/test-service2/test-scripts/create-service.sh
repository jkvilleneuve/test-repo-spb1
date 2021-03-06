#!/bin/sh

export MODULE_NAME=test-service2
export PROJECT_NAME="z-test-project"
export BUILD_SCRIPT_DIR=${WORKSPACE}/openshift-deploy/${MODULE_NAME}/test-scripts

export DOCKER_REGISTRY="docker.io/jkvilleneuve"
export ROUTE_HOST="z-test-project.apps.neoflex.ru"

export MODULE_PORT=8081
export MODULE_PATH="/${MODULE_NAME}/getSum"

echo "name: [${MODULE_NAME}]"
echo "tag: [${MODULE_TAG}]"

mkdir -vp ${BUILD_SCRIPT_DIR}/tmp 2>/dev/null
rm -rf ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.*

for TEMPLATE in $(ls ${BUILD_SCRIPT_DIR}/template); do
  envsubst < ${BUILD_SCRIPT_DIR}/template/$TEMPLATE > ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.$TEMPLATE
done

WORK_DIR="openshift-deploy"
ssh root@172.17.78.9 mkdir -vp ${WORK_DIR}/test/${MODULE_NAME} 2>/dev/null
ssh root@172.17.78.9 rm -rf ${WORK_DIR}/test/${MODULE_NAME}/${MODULE_NAME}.*
scp ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.* root@172.17.78.9:${WORK_DIR}/test/${MODULE_NAME}/
ssh root@172.17.78.9 "cd ${WORK_DIR}/test/${MODULE_NAME};. ${MODULE_NAME}.deploy-module.sh"

exit