#!/bin/bash

set -e

# Define the library name
NAME=$1
# Ensure NAME is set
if [ -z "$NAME" ]; then
    echo "Please set the NAME variable."
    exit 1
fi
LIB_NAME="lib${NAME}"

# Define the iOS architectures
IOS_OUTPUT_DIR="dist/ios"

xcodebuild -create-xcframework \
			-output dist/ios/${LIB_NAME}.xcframework \
			-library dist/ios/${LIB_NAME}-amd64.a \
			-headers dist/ios/${LIB_NAME}-amd64.h \
			-library dist/ios/${LIB_NAME}-arm64.a \
			-headers dist/ios/${LIB_NAME}-arm64.h