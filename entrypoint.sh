#!/bin/bash

set -e

USERNAME=$1
PASSWORD=$2
REPOSITORY=$3
PAT=$4
PAT_STRING=$5
REGISTRY=$6
TAG=$7

for i in $*; do 
   echo $i 
done
#if [ -z $USERNAME ]; then
#  echo 'Required username parameter'
#  exit 1
#fi

#if [ -z $PASSWORD ]; then
#  echo 'Required password parameter'
#  exit 1
#fi

if [ -z $REPOSITORY ]; then
  echo 'Required repository parameter'
  exit 1
fi

if [[ -z $TAG ]]; then
  echo 'Tag to snapshot'
  TAG=$(date '+%Y%m%d%H%M%S')
fi

if [ -z $PAT ]; then
  echo 'Required paramater PAT not passed'
  exit 1
fi

if [ -z $PAT_STRING ]; then
  echo 'Required paramater PAT_STRING not passed'
  exit 1
else
  echo "PAT STRING: ${PAT_STRING}"
fi

IMAGE=$REPOSITORY:$TAG
if [ -n "$REGISTRY" ]; then
  IMAGE=$REGISTRY/$IMAGE
fi

touch ./env
echo "PAT_STRING=${PAT_STRING}" > ./env
echo "PAT=${PAT}" >> ./env
cat ./env

export PAT_STRING=$PAT_STRING
export PAT=$PAT
docker build --env-file ./env -t $IMAGE .
#docker build --env PAT --env PAT_STRING -t $IMAGE .
#docker login --username "$USERNAME" --password "$PASSWORD" $REGISTRY
#docker push $IMAGE

echo ::set-output name=image::$IMAGE
