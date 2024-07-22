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
IOS_UNIVERSAL_OUTPUT_DIR="$IOS_OUTPUT_DIR/universal"
IOS_ARCHS=("arm64" "amd64")

# Build for iOS
echo "Building for iOS..."
mkdir -p $IOS_OUTPUT_DIR
for ARCH in "${IOS_ARCHS[@]}"; do
    case $ARCH in
        arm64)
            GOARCH=arm64
            CC="xcrun --sdk iphoneos clang"
            ;;
        amd64)
            GOARCH=amd64
            CC="xcrun --sdk iphonesimulator clang"
            ;;
    esac

    # Set up environment variables for cross-compiling
    export GOARCH
    export CC

    # Build the static library
    CGO_ENABLED=1 GOOS=darwin go build -buildmode=c-archive -o "$IOS_OUTPUT_DIR/$LIB_NAME-$ARCH.a" ${NAME}.go
done

# Combine iOS static libraries into a universal library
echo "Combining iOS static libraries into a universal library..."
mkdir -p $IOS_UNIVERSAL_OUTPUT_DIR
lipo -create -output "$IOS_UNIVERSAL_OUTPUT_DIR/$LIB_NAME.a" "$IOS_OUTPUT_DIR/$LIB_NAME-arm64.a" "$IOS_OUTPUT_DIR/$LIB_NAME-amd64.a"

echo "Build completed. Libraries are in the $IOS_UNIVERSAL_OUTPUT_DIR directories."