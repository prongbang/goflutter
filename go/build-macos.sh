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

# Define the macOS architectures
MACOS_OUTPUT_DIR="dist/macos"

# Build for macOS
echo "Building for macOS..."
mkdir -p $MACOS_OUTPUT_DIR
mkdir -p "$MACOS_OUTPUT_DIR/universal"

CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 SDK=macos go build -trimpath -buildmode=c-shared -o dist/macos/${LIB_NAME}-arm64.dylib bridge/${NAME}.gen.go
CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 SDK=macos go build -trimpath -buildmode=c-shared -o dist/macos/${LIB_NAME}-amd64.dylib bridge/${NAME}.gen.go
lipo -create dist/macos/${LIB_NAME}-arm64.dylib dist/macos/${LIB_NAME}-amd64.dylib -output dist/macos/universal/${LIB_NAME}.dylib
install_name_tool -id "@rpath/${LIB_NAME}.dylib" dist/macos/universal/${LIB_NAME}.dylib
mv dist/macos/universal/${LIB_NAME}.dylib dist/macos/universal/${LIB_NAME}.dylib