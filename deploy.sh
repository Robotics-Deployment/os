#!/bin/bash

docker login registry.digitalocean.com

docker tag robotics-deployment:os registry.digitalocean.com/rdcr/robotics-deployment:os
docker push registry.digitalocean.com/rdcr/robotics-deployment:os