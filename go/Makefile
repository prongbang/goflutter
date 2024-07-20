setup:
	go get github.com/csnewman/flutter-go-bridge/parser@v0.2.0
	go get github.com/csnewman/flutter-go-bridge/generator@v0.2.0
	go get github.com/csnewman/flutter-go-bridge/cmd/flutter-go-bridge@v0.2.0

ndk-list:
	ls ~/Library/Android/sdk/ndk

sdk-list:
	ls /Library/Developer/CommandLineTools/SDKs

env:
	export CGO_LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib"
	export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/23.1.7779620
	export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk

create:
	mkdir go && cd go && go mod init com.github.com/prongbang/example && mkdir bridge

gen:
	go generate

chmod:
	chmod -x build-ios.sh
	chmod -x build-android.sh
	chmod -x pack.sh

build-ios:
	sh build-ios.sh example

build-android:
	sh build-android.sh example

pack:
	sh pack.sh example