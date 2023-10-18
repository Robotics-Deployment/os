#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

(
cd "${DIR}" || exit

# Define directory to scan and pattern to look for
SCAN_DIR="../poky/build/tmp-glibc/deploy/images"
PATTERN="robotics-deployment-core-*-*.wic.bz2"
S3_BUCKET="s3://robotics-deployment/images/base"

# Check if s3cmd is installed
if ! command -v s3cmd &> /dev/null
then
    echo "s3cmd could not be found, please install it."
    exit 1
fi

# Check if the scan directory exists
if [ ! -d "$SCAN_DIR" ]; then
    echo "Directory $SCAN_DIR does not exist."
    exit 1
fi

# Find files that match the pattern and upload them to S3
files=$(find "$SCAN_DIR" -maxdepth 3 -name "$PATTERN" -type f)
if [ -z "$files" ]; then
    echo "No files found matching the pattern."
    exit 1
fi

if [ -z "$MACHINE" ]; then
    filtered_files="$files"
    echo "MACHINE is not set, uploading all files."
else
    # Loop through each file in the list
    for file in $files; do
        if [[ "$file" == *"$MACHINE"* ]]; then
            filtered_files+="$file "
        fi
    done
    if [ -z "$filtered_files" ]; then
        echo "No files found matching the pattern=${PATTERN} and MACHINE=${MACHINE}."
        exit 1
    fi
fi

echo "MACHINE=${MACHINE}"
echo "PATTERN=${PATTERN}"

for file in $filtered_files; do
    filename=$(basename "$file")
    echo "Uploading $file to $S3_BUCKET..."
    s3cmd put "$file" "$S3_BUCKET/$filename"
done
)