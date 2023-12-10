#!/bin/bash

source ~/source/kubernetes-cluster/deployment/app/baseDeploy.sh

IMAGE_NAME="kubegres-website"
IMAGE_PROJECT_NAME="reactivetech"
KUBERNETES_NAMESPACE="static-websites"

function buildAppAndCopyOutput() {
  gigo gigo.yaml
  cp -a target/. $BUILD_TARGET_PATH/image
  cp -rp nginx $BUILD_TARGET_PATH
  cp docker/Dockerfile $BUILD_TARGET_PATH
}

deploy
