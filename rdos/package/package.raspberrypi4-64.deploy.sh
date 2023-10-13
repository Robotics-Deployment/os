#!/bin/bash

# Get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

(
cd "${DIR}" || exit

docker compose -f package.raspberrypi4-64.compose.yaml build

docker login registry.digitalocean.com

docker tag robotics-deployment:package-raspberrypi4-64 registry.digitalocean.com/rdcr/robotics-deployment:package-raspberrypi4-64
docker push registry.digitalocean.com/rdcr/robotics-deployment:package-raspberrypi4-64
)