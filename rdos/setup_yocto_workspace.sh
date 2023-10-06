#!/bin/bash

# Get script working directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check if the poky directory exists
if [ -d "${SCRIPT_DIR}/poky" ]; then
    echo "poky directory already exists. Exiting."
    exit 1
fi

(
cd "${SCRIPT_DIR}" || exit 1

# Download the yocto project
git clone --depth 1 -b mickledore git://git.yoctoproject.org/poky.git
cd poky || exit 1
mkdir sources
cd sources || exit 1
git clone --depth 1 -b mickledore https://github.com/openembedded/meta-openembedded.git
git clone --depth 1 -b mickledore git://git.yoctoproject.org/meta-raspberrypi.git
git clone --depth 1 -b mickledore git://git.yoctoproject.org/meta-virtualization.git
echo "finished downloading poky."

git clone -b mickledore https://github.com/Robotics-Deployment/meta-robotics-deployment.git
echo "################################################################################"
echo "source oe-init-build-env from inside the docker container to start building."
echo "################################################################################"
)