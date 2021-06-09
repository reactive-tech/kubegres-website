#!/bin/bash

source ~/source/kubernetes-cluster/local-cluster/util/deploymentUtilities.sh

exitIfEnvArgIsMissing $1
exitIfVersionArgIsMissing $2

BUILD_ENV=$1
BUILD_VERSION=$2
REBUILD_DEV_IMAGE=$3

BUILD_IMG_DEPLOYMENT_NAME="kubegres-website"
BUILD_IMG_NAMESPACE="static-websites"
BUILD_IMG="reactivetechio/$BUILD_IMG_DEPLOYMENT_NAME:$BUILD_VERSION"

if [ "$BUILD_ENV" == "dev" ]; then
  BUILD_IMG="localhost:5000/$BUILD_IMG"
fi

echo "Deploying $BUILD_IMG in ${BUILD_ENV} environment"

gigo deployment/Gigo.yaml
cp deployment/Dockerfile /usr/share/dev-output/$BUILD_IMG_NAMESPACE/$BUILD_IMG_DEPLOYMENT_NAME

if [ "$BUILD_ENV" == "prod" ]; then
  buildAndDeployedDockerImg $BUILD_IMG $BUILD_IMG_DEPLOYMENT_NAME $BUILD_IMG_NAMESPACE

elif [ "$BUILD_ENV" == "dev" ]; then

  if ! isDevImageLocallyDeployed $BUILD_IMG $BUILD_IMG_DEPLOYMENT_NAME $BUILD_IMG_NAMESPACE; then

    buildAndDeployedDockerImg $BUILD_IMG $BUILD_IMG_DEPLOYMENT_NAME $BUILD_IMG_NAMESPACE
    echo "To deploy the DEV image, we are patching the Deployment resource '$BUILD_IMG_DEPLOYMENT_NAME' in the namespace: '$BUILD_IMG_NAMESPACE'"
    kubectl patch deployment $BUILD_IMG_DEPLOYMENT_NAME -n $BUILD_IMG_NAMESPACE --patch "$(cat deployment/dev/deployment-patch.yaml)"

  elif [ "$REBUILD_DEV_IMAGE" == "r" ]; then

    buildAndDeployedDockerImg $BUILD_IMG $BUILD_IMG_DEPLOYMENT_NAME $BUILD_IMG_NAMESPACE
    echo "To deploy the latest DEV image, we are restarting the Deployment resource '$BUILD_IMG_DEPLOYMENT_NAME' in the namespace: '$BUILD_IMG_NAMESPACE'"
    kubectl rollout restart deployment $BUILD_IMG_DEPLOYMENT_NAME -n $BUILD_IMG_NAMESPACE
  fi

fi
