#!/bin/bash

source ~/source/kubernetes-cluster/deployment/app/baseDeploy.sh

BUILD_IMG_DEPLOYMENT_NAME="kubegres-website"
BUILD_IMG_NAMESPACE="static-websites"

function buildAppAndCopyOutput() {
  gigo gigo.yaml
  cp docker/Dockerfile $BUILD_TARGET_PATH
  cp -rp nginx $BUILD_TARGET_PATH
}

deploy
