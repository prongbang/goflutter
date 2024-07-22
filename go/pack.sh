NAME=$1

LIB_NAME="lib${NAME}"

mkdir -p ../android/src/main/jniLibs/arm64-v8a
mkdir -p ../android/src/main/jniLibs/armeabi-v7a
mkdir -p ../android/src/main/jniLibs/x86
mkdir -p ../android/src/main/jniLibs/x86_64
cp -r dist/android/jniLibs/arm64-v8a/${LIB_NAME}.so ../android/src/main/jniLibs/arm64-v8a/${LIB_NAME}.so
cp -r dist/android/jniLibs/armeabi-v7a/${LIB_NAME}.so ../android/src/main/jniLibs/armeabi-v7a/${LIB_NAME}.so
cp -r dist/android/jniLibs/x86/${LIB_NAME}.so ../android/src/main/jniLibs/x86/${LIB_NAME}.so
cp -r dist/android/jniLibs/x86_64/${LIB_NAME}.so ../android/src/main/jniLibs/x86_64/${LIB_NAME}.so
cp -r dist/ios/universal/${LIB_NAME}.a ../ios/Classes/${LIB_NAME}.a
cp -r dist/ios/${LIB_NAME}-arm64.a ../ios/${LIB_NAME}.a
cp -r ${LIB_NAME}.h ../ios/Classes/${LIB_NAME}.h
cp -r dist/ios/${LIB_NAME}-arm64.h ./${LIB_NAME}.h