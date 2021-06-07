#!/bin/bash

source ~/source/kubernetes-cluster/local-cluster/util/deploymentUtilities.sh

exitIfEnvArgIsMissing $1
exitIfVersionArgIsMissing $2

BUILD_ENV=$1
BUILD_VERSION=$2

BUILD_IMG="reactivetechio/kubegres-website:$BUILD_VERSION"
BUILD_IMG_DEPLOYMENT_NAME="kubegres-website"
BUILD_IMG_NAMESPACE="static-websites"

if [ "$BUILD_ENV" == "dev" ]; then
  BUILD_IMG="localhost:5000/$BUILD_IMG"
fi

echo "Deploying $BUILD_IMG in ${BUILD_ENV} environment"

gigo deployment/Gigo.yaml
cp deployment/Dockerfile /usr/share/dev-output/kubegres-website

if [ "$BUILD_ENV" == "prod" ]; then
    buildAndDeployedDockerImg $BUILD_IMG

elif [ "$BUILD_ENV" == "dev" ]; then

  if ! isDevImageLocallyDeployed $BUILD_IMG $BUILD_IMG_DEPLOYMENT_NAME $BUILD_IMG_NAMESPACE; then
    buildAndDeployedDockerImg $BUILD_IMG
  fi

  kubectl apply -f deployment/dev/deployment.yaml
fi
