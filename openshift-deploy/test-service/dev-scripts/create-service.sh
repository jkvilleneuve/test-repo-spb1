#!/bin/sh

export MODULE_NAME=test-service
export PROJECT_NAME="z-dev-project"
export BUILD_SCRIPT_DIR=${WORKSPACE}/openshift-deploy/${MODULE_NAME}/dev-scripts

export DOCKER_REGISTRY="docker.io/jkvilleneuve"
export ROUTE_HOST="z-dev-project.apps.oc.ymelnik.ru"

export MODULE_PORT=8081
export MODULE_PATH="/${MODULE_NAME}/calculate"

export MASTER_IP=172.17.78.9

echo "name: [${MODULE_NAME}]"
echo "tag: [${MODULE_TAG}]"

mkdir -vp ${BUILD_SCRIPT_DIR}/tmp 2>/dev/null
rm -rf ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.*

for TEMPLATE in $(ls ${BUILD_SCRIPT_DIR}/template); do
  envsubst < ${BUILD_SCRIPT_DIR}/template/$TEMPLATE > ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.$TEMPLATE
done

WORK_DIR="openshift-deploy"
ssh root@${MASTER_IP} mkdir -vp ${WORK_DIR}/dev/${MODULE_NAME} 2>/dev/null
ssh root@${MASTER_IP} rm -rf ${WORK_DIR}/dev/${MODULE_NAME}/${MODULE_NAME}.*
scp ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.* root@${MASTER_IP}:${WORK_DIR}/dev/${MODULE_NAME}/
ssh root@${MASTER_IP} "cd ${WORK_DIR}/dev/${MODULE_NAME};. ${MODULE_NAME}.deploy-module.sh"

exit