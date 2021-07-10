#!/bin/bash

set -e

USERNAME=$1
PASSWORD=$2
REPOSITORY=$3
REGISTRY=$4
TAG=$5
PAT=$6
PAT_STRING=$7

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
fi



IMAGE=$REPOSITORY:$TAG
if [ -n "$REGISTRY" ]; then
  IMAGE=$REGISTRY/$IMAGE
fi

git config --global credential.helper store && echo "$PAT_STRING" > ~/.git-credentials
docker build -t $IMAGE .
#docker login --username "$USERNAME" --password "$PASSWORD" $REGISTRY
#docker push $IMAGE

echo ::set-output name=image::$IMAGE
