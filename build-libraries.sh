#!/bin/bash

if [[ -z "${NDK_HOME}" ]];then
    echo "ERROR: \$NDK_HOME environment variable is not set."
    exit 1
else
    echo "NDK_HOME is set to $NDK_HOME"
fi

SDK_PATH=morpheus-rust
TOOLCHAINPATH=$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin

cd $SDK_PATH
AR=$TOOLCHAINPATH/x86_64-linux-android-ar CC=$TOOLCHAINPATH/x86_64-linux-android29-clang cargo build --target x86_64-linux-android --release
AR=$TOOLCHAINPATH/aarch64-linux-android-ar CC=$TOOLCHAINPATH/aarch64-linux-android29-clang cargo build --target aarch64-linux-android --release

cd -

JNI_LIBS=native_sdk/android/src/main/jniLibs
rm -rf $JNI_LIBS
mkdir -p $JNI_LIBS/x86_64
mkdir -p $JNI_LIBS/arm64-v8a
cp $SDK_PATH/target/x86_64-linux-android/release/libmorpheus_sdk.so $JNI_LIBS/x86_64
cp $SDK_PATH/target/aarch64-linux-android/release/libmorpheus_sdk.so $JNI_LIBS/arm64-v8a
