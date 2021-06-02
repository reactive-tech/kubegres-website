function checkArgs() {
  if [ -z "$1" ];
    then
      return 0
  elif [ $1 != 'dev' ] && [ $1 != 'prod' ];
  then
      return 0
  fi

  return 1
}

if checkArgs $1;
  then
    echo "Expected argument missing."
    echo "A valid argument is either: 'dev' or 'prod'."
    exit 1
fi

BUILD_ENVIRONMENT=$1

echo "Deploying kubegres-website in ${BUILD_ENVIRONMENT}"

gigo deployment/${BUILD_ENVIRONMENT}/Gigo.yaml

if [ $BUILD_ENVIRONMENT == 'prod' ];
 then
    docker build -t reactivetechio/kubegres-website:latest -f deployment/prod/Dockerfile .
    docker push reactivetechio/kubegres-website:latest
fi
