gen:
	go generate

build:
	sh build.sh

pack:
	mkdir -p ../android/src/main/jniLibs/arm64-v8a
	mkdir -p ../android/src/main/jniLibs/armeabi-v7a
	mkdir -p ../android/src/main/jniLibs/x86
	mkdir -p ../android/src/main/jniLibs/x86_64
	cp -r dist/android/jniLibs/arm64-v8a/libexample.so ../android/src/main/jniLibs/arm64-v8a/libexample.so
	cp -r dist/android/jniLibs/armeabi-v7a/libexample.so ../android/src/main/jniLibs/armeabi-v7a/libexample.so
	cp -r dist/android/jniLibs/x86/libexample.so ../android/src/main/jniLibs/x86/libexample.so
	cp -r dist/android/jniLibs/x86_64/libexample.so ../android/src/main/jniLibs/x86_64/libexample.so
	cp -r dist/ios/universal/libexample.a ../ios/Classes/libexample.a
	cp -r dist/ios/libexample-arm64.a ../ios/Classes/libexample.a
	cp -r dist/ios/libexample-arm64.h ../ios/Classes/libexample.h
	cp -r dist/ios/libexample-arm64.h ./libexample.h