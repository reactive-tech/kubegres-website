#!/bin/bash

BUILD_IMG_DEPLOYMENT_NAME="kubegres-website"
BUILD_IMG_NAMESPACE="static-websites"

source ~/source/kubernetes-cluster/deployment/baseDeploy.sh

function copyDevOutput() {
  echo "Copying dev output to $BUILD_TARGET_PATH"
  gigo deployment/Gigo.yaml
  cp deployment/Dockerfile $BUILD_TARGET_PATH
  cp -rp deployment/nginx $BUILD_TARGET_PATH
}

deploy
