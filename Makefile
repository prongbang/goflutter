channel:
	flutter channel master

enable:
	flutter config --enable-native-assets

build:
	dart --enable-experiment=native-assets run build.dart