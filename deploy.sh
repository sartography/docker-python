#!/usr/bin/env bash

function error_handler() {
  >&2 echo "Exited with BAD EXIT CODE '${2}' in ${0} script at line: ${1}."
  exit "$2"
}
trap 'error_handler ${LINENO} $?' ERR
set -o errtrace -o errexit -o nounset -o pipefail

#########################################################################
# Builds the Docker image for the current git branch on Travis CI and
# publishes it to Docker Hub.
#
# Parameters:
# $1: Docker Hub repository to publish to
#
# Required environment variables (place in Settings menu on Travis CI):
# $DOCKER_USERNAME: Docker Hub username
# $DOCKER_TOKEN: Docker Hub access token
#########################################################################

echo 'Building Docker image...'
docker_repo="${1:-}"

function branch_to_tag () {
  if [ "$1" == "master" ]; then echo "latest"; else echo "$1" ; fi
}

function branch_to_deploy_group() {
  if [[ $1 =~ ^(rrt\/.*)$ ]]; then echo "rrt"; else echo "crconnect" ; fi
}

docker_tag=$(branch_to_tag "$TRAVIS_BRANCH")

deploy_group=$(branch_to_deploy_group "$TRAVIS_BRANCH")

if [ "$deploy_group" == "rrt" ]; then
  IFS='/' read -ra ARR <<< "$TRAVIS_BRANCH"  # Split branch on '/' character
  docker_tag=$(branch_to_tag "rrt_${ARR[1]}")
fi

echo "docker_repo = $docker_repo"
echo "docker_tag = $docker_tag"

echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker build -f Dockerfile -t "$docker_repo:$docker_tag" .


# Push Docker image to Docker Hub
echo "Publishing to Docker Hub..."
docker push "${docker_repo}:${docker_tag}"
echo "Done."
