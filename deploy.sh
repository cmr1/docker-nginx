#!/bin/bash

function push() {
  # Get the tag from argument to this function
  tag="${1:-latest}"

  echo "Deploying tagged release '$tag'"

  # Authenticate with DockerHub
  docker login -u="$DOCKER_HUB_USERNAME" -p="$DOCKER_HUB_PASSWORD" 

  # Tag the Docker image
  docker tag cmr1/nginx cmr1/nginx:$tag
  
  # Push the tagged image
  docker push cmr1/nginx:$tag
}

if [ ! -z "$TRAVIS_TAG" ]; then
  push $TRAVIS_TAG
elif [ "$TRAVIS_BRANCH" == "master" ]; then
  push latest
fi