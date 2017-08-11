#!/bin/sh
set +e

LIST=$(cat ${WORKSPACE}/openshift-deploy/moduleList.properties | grep -v '^#')

#chmod +x ${WORKSPACE}/trunk/z-build-script-docker/scripts/*.sh

export BUILD_SCRIPT_DIR=${WORKSPACE}/openshift-deploy/prod-scripts

for module in $LIST
do
  export MODULE_NAME=$module
  . ${BUILD_SCRIPT_DIR}/create-service.sh
done
