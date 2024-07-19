#!/bin/bash

set -e

export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/25.2.9519653

# Ensure ANDROID_NDK_HOME is set
if [ -z "$ANDROID_NDK_HOME" ]; then
    echo "Please set the ANDROID_NDK_HOME environment variable to your NDK installation path."
    exit 1
fi

# Define the output directories
ANDROID_OUTPUT_DIR="dist/android/jniLibs"
IOS_OUTPUT_DIR="dist/ios"
IOS_UNIVERSAL_OUTPUT_DIR="$IOS_OUTPUT_DIR/universal"

# Define the library name
LIB_NAME="libexample"

# Define the Android architectures and their respective NDK toolchain binaries
ANDROID_ARCHS=("armeabi-v7a" "arm64-v8a" "x86" "x86_64")
ANDROID_CC_ARM="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi21-clang"
ANDROID_CC_ARM64="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang"
ANDROID_CC_X86="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/i686-linux-android21-clang"
ANDROID_CC_X86_64="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/x86_64-linux-android21-clang"

# Define the iOS architectures
IOS_ARCHS=("arm64" "amd64")

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
    CGO_ENABLED=1 GOOS=android go build -buildmode=c-shared -o "$ARCH_OUTPUT_DIR/$LIB_NAME.so" bridge/bridge.gen.go
done

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
    CGO_ENABLED=1 GOOS=darwin go build -buildmode=c-archive -o "$IOS_OUTPUT_DIR/$LIB_NAME-$ARCH.a" bridge/bridge.gen.go
done

# Combine iOS static libraries into a universal library
echo "Combining iOS static libraries into a universal library..."
mkdir -p $IOS_UNIVERSAL_OUTPUT_DIR
lipo -create -output "$IOS_UNIVERSAL_OUTPUT_DIR/$LIB_NAME.a" "$IOS_OUTPUT_DIR/$LIB_NAME-arm64.a" "$IOS_OUTPUT_DIR/$LIB_NAME-amd64.a"

echo "Build completed. Libraries are in the $ANDROID_OUTPUT_DIR and $IOS_UNIVERSAL_OUTPUT_DIR directories."
