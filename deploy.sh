#!/bin/bash

if [ "$TRAVIS_BRANCH" == "master" ]; then
  echo "Deploying master branch as 'latest'"

  export TRAVIS_TAG=latest;
fi

if [ -z "$TRAVIS_TAG" ]; then
  tag="${TRAVIS_TAG:-latest}"
  
  echo "Deploying tagged release '$tag'"

  # Authenticate with DockerHub
  docker login -u="$DOCKER_HUB_USERNAME" -p="$DOCKER_HUB_PASSWORD" 

  # Tag the Docker image
  docker tag cmr1/nginx cmr1/nginx:$tag
  
  # Push the tagged image
  docker push cmr1/nginx:$tag
fi