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
#AR=$TOOLCHAINPATH/arm-linux-androideabi-ar CC=$TOOLCHAINPATH/arm-linux-androideabi-ld cargo build --target armv7-linux-androideabi --release
cd -

JNI_LIBS=native_sdk/android/src/main/jniLibs

rm -rf $JNI_LIBS
mkdir -p $JNI_LIBS/x86_64
#mkdir -p $JNI_LIBS/armeabi-v7a
cp $SDK_PATH/target/x86_64-linux-android/release/libmorpheus_sdk.so $JNI_LIBS/x86_64
#cp $SDK_PATH/target/armv7-linux-androideabi/release/libmorpheus_sdk.so $JNI_LIBS/armeabi-v7a