#!/bin/sh
####################################################################################################
## WARNING!!!
## Dont use shell variables in this script
## They will replace in root script
####################################################################################################


if [ -z "$(oc get svc ${MODULE_NAME} --template='{{.metadata.name}}' -n ${PROJECT_NAME} 2>/dev/null)" ]; then
  echo "####################################################################################################"
  echo "# Create service: [${MODULE_NAME}]"
  echo "####################################################################################################"
  oc create -f ${MODULE_NAME}.svc.yaml
  oc create -f ${MODULE_NAME}.route.yaml
  oc create -f ${MODULE_NAME}.dc.yaml
fi

echo "####################################################################################################"
echo "# Update imagestream: [${MODULE_NAME}]"
echo "####################################################################################################"
oc delete imagestream ${MODULE_NAME} -n ${PROJECT_NAME}
oc create -f ${MODULE_NAME}.is.yaml

