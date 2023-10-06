#!/bin/bash

# This script is used to configure the RDOS installation.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

(
cd "${SCRIPT_DIR}" || exit 1

# Check if poky directory exists
if [ ! -d "${SCRIPT_DIR}/poky" ]; then
    echo "poky directory does not exist. Exiting."
    exit 1
fi

cp -r build "${SCRIPT_DIR}/poky/"
)