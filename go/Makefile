ndk-list:
	ls ~/Library/Android/sdk/ndk

sdk-list:
	ls /Library/Developer/CommandLineTools/SDKs

env:
	export CGO_LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib"
	export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
    export ANDROID_HOME=$HOME/Library/Android/sdk

create:
	mkdir go && cd go && go mod init com.github.com/prongbang/hello

gen-header:
	CGO_ENABLED=1 GOOS=darwin go build -buildmode=c-archive -o libhello.a hello.go

chmod:
	chmod -x build-ios.sh
	chmod -x build-android.sh
	chmod -x pack.sh

build-ios:
	export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk
	sh build-ios.sh hello

build-android:
	export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/23.1.7779620
	sh build-android.sh hello

pack:
	sh pack.sh hello