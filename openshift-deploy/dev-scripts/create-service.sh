#!/bin/sh

if [ -z "${MODULE_NAME}" ]; then
  echo "Error: empty module name."
  exit
fi

echo "name: [${MODULE_NAME}]"

. ${BUILD_SCRIPT_DIR}/set-env.sh

mkdir -v ${BUILD_SCRIPT_DIR}/tmp 2>/dev/null
rm -rf ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.*

for TEMPLATE in $(ls ${BUILD_SCRIPT_DIR}/template); do
  envsubst < ${BUILD_SCRIPT_DIR}/template/$TEMPLATE > ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.$TEMPLATE
done

WORK_DIR="openshift-deploy"
ssh root@194.67.211.163 mkdir -v ${WORK_DIR} 2>/dev/null
ssh root@194.67.211.163 rm -rf ${WORK_DIR}/${MODULE_NAME}.*
scp ${BUILD_SCRIPT_DIR}/tmp/${MODULE_NAME}.* root@194.67.211.163:${WORK_DIR}
#ssh root@194.67.211.163 "cd ${WORK_DIR};. ${MODULE_NAME}.deploy-module.sh"

exit