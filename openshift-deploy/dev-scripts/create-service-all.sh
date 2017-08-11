#!/bin/sh
set +e

LIST=$(cat ${WORKSPACE}/trunk/z-build-script-docker/openshift-moduleList.properties | grep -v '^#')

#chmod +x ${WORKSPACE}/trunk/z-build-script-docker/scripts/*.sh

export BUILD_SCRIPT_DIR=${WORKSPACE}/trunk/z-build-script-docker/scripts

for module in $LIST
do
  export MODULE_NAME=$module
  . ${BUILD_SCRIPT_DIR}/create-service.sh
done
