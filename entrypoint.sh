#!/bin/bash

set -e

# These variables are set in the docker action in the repository that's getting built.
USERNAME=$1
PASSWORD=$2
REPOSITORY=$3
DOCKER_REPOSITORY=$4
REGISTRY=$5
PAT_STRING=$6
TAG=$7

# Santiy checks
if [ -z $USERNAME ]; then
  echo 'Required username parameter'
  exit 1
fi

if [ -z $PASSWORD ]; then
  echo 'Required password parameter'
  exit 1
fi

if [ -z $REPOSITORY ]; then
  echo 'Required repository parameter'
  exit 1
fi

if [ -z $DOCKER_REPOSITORY ]; then
  echo 'Required docker repository parameter'
  exit 1
fi

if [ -z $PAT_STRING ]; then
  echo 'Required paramater PAT_STRING not passed'
  exit 1
fi

if [[ "$TAG" =~ .*"refs/heads/".* ]]; then
  # If no actual tag, call it latest
  TAG="latest"
fi

# Set image name
IMAGE=$DOCKER_REPOSITORY:$TAG
if [ -n "$REGISTRY" ]; then
  IMAGE=$REGISTRY/$IMAGE
fi

# Github Personal Access Token for allowing the go modules to be cloned
export PAT_STRING=$PAT_STRING 

# Build container
docker build --build-arg PAT_STRING -t $IMAGE .

# Once we have a registry setup to push built containers to 
docker login --username "$USERNAME" --password "$PASSWORD" $REGISTRY
docker push $IMAGE

# This output then able to be used in the action.yml files using ${{steps.docker.outputs.image}}'
echo ::set-output name=image::$IMAGE