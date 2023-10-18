#!/bin/bash

# Get script working directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PROJECT_DIR="${SCRIPT_DIR}"/..

# Verify that the poky directory exists
if [ ! -d "${PROJECT_DIR}/poky" ]; then
    echo "poky directory does not exist. Exiting."
    exit 1
fi

# Verify that the embedded directory exists
if [ ! -d "${PROJECT_DIR}/embedded" ]; then
    echo "embedded directory does not exist. Exiting."
    exit 1
fi

# Verify that the meta-robotics-deployment directory exists
if [ ! -d "${PROJECT_DIR}/poky/sources/meta-robotics-deployment" ]; then
    echo "meta-robotics-deployment directory does not exist. Exiting."
    exit 1
fi

# Verify build configuration is ROBOTICS DEPLOYMENT CONFIGURATION
if [ ! -f "${PROJECT_DIR}/poky/build/conf/bblayers.conf" ]; then
    echo "bblayers.conf does not exist. Exiting."
    exit 1
fi

# Verify build configuration is ROBOTICS DEPLOYMENT CONFIGURATION
if [ ! -f "${PROJECT_DIR}/poky/build/conf/local.conf" ]; then
    echo "local.conf does not exist. Exiting."
    exit 1
fi

if ! grep -q "ROBOTICS DEPLOYMENT CONFIGURATION" "${PROJECT_DIR}/poky/build/conf/bblayers.conf"; then
    echo "The bblayers.conf is not 'ROBOTICS DEPLOYMENT CONFIGURATION'. Exiting."
    exit 1
fi

if ! grep -q "ROBOTICS DEPLOYMENT CONFIGURATION" "${PROJECT_DIR}/poky/build/conf/local.conf"; then
    echo "The local.conf is not 'ROBOTICS DEPLOYMENT CONFIGURATION'. Exiting."
    exit 1
fi

echo "Pre-build checks passed"

(
cd "${PROJECT_DIR}" || exit 1
echo "Building embedded docker image..."
echo "MACHINE=${MACHINE}"
docker compose up
)
