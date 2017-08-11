#!/bin/sh
####################################################################################################
## WARNING!!!
## Dont use shell variables in this script
## They will replace in root script
####################################################################################################


if [ -z "$(oc get svc ${MODULE_NAME} --template='{{.metadata.name}}' 2>/dev/null)" ]; then
  echo "####################################################################################################"
  echo "# Create service: [${MODULE_NAME}]"
  echo "####################################################################################################"
  oc create -f ${MODULE_NAME}.svc.yaml
  oc create -f ${MODULE_NAME}.route.yaml
  oc create -f ${MODULE_NAME}.dc.yaml
fi

# Cleanup
#docker rmi $(docker images | grep "<none>" | awk "{print $3}" 2>/dev/null) 2>/dev/null

echo "####################################################################################################"
echo "# Tag and Push: [${MODULE_NAME}]"
echo "####################################################################################################"
#docker tag ${MODULE_NAME}:1.0.0 ${OPENSHIFT_REGISTRY}/${PROJECT_NAME}/${MODULE_NAME}:${MODULE_TAG}
#docker push ${OPENSHIFT_REGISTRY}/${PROJECT_NAME}/${MODULE_NAME}:${MODULE_TAG}

echo "####################################################################################################"
echo "# Update imagestream: [${MODULE_NAME}]"
echo "####################################################################################################"
oc delete imagestream ${MODULE_NAME} -n ${PROJECT_NAME}
oc create -f ${MODULE_NAME}.is.yaml

