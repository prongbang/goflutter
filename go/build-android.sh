#!/bin/bash

set -e

# Ensure ANDROID_NDK_HOME is set
if [ -z "$ANDROID_NDK_HOME" ]; then
    echo "Please set the ANDROID_NDK_HOME environment variable to your NDK installation path."
    exit 1
fi

# Define the library name
NAME=$1
# Ensure NAME is set
if [ -z "$NAME" ]; then
    echo "Please set the NAME variable."
    exit 1
fi
LIB_NAME="lib${NAME}"


# Define the output directories
ANDROID_OUTPUT_DIR="dist/android/jniLibs"

# Define the Android architectures and their respective NDK toolchain binaries
ANDROID_ARCHS=("armeabi-v7a" "arm64-v8a" "x86" "x86_64")
ANDROID_CC_ARM="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi21-clang"
ANDROID_CC_ARM64="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang"
ANDROID_CC_X86="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/i686-linux-android21-clang"
ANDROID_CC_X86_64="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/x86_64-linux-android21-clang"

# Build for Android
echo "Building for Android..."
for ARCH in "${ANDROID_ARCHS[@]}"; do
    case $ARCH in
        armeabi-v7a)
            GOARCH=arm
            GOARM=7
            CC=$ANDROID_CC_ARM
            ;;
        arm64-v8a)
            GOARCH=arm64
            CC=$ANDROID_CC_ARM64
            ;;
        x86)
            GOARCH=386
            CC=$ANDROID_CC_X86
            ;;
        x86_64)
            GOARCH=amd64
            CC=$ANDROID_CC_X86_64
            ;;
    esac

    # Set up environment variables for cross-compiling
    export GOARCH
    export GOARM
    export CC

    # Create the architecture-specific output directory if it doesn't exist
    ARCH_OUTPUT_DIR="$ANDROID_OUTPUT_DIR/$ARCH"
    mkdir -p $ARCH_OUTPUT_DIR

    # Build the shared library
    CGO_ENABLED=1 GOOS=android go build -buildmode=c-shared -o "$ARCH_OUTPUT_DIR/$LIB_NAME.so" ${NAME}.go
done

echo "Build completed. Libraries are in the $ANDROID_OUTPUT_DIR directories."