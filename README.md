# Morpheus Apps

This repository contains applications for all participants described in the Morpheus specification.

## Development

### Requirements

* Rust, Cargo
* Flutter, Dart
* Bash
* Android SDK, NDK

#### Setup Android SDK, NDK

1. Download [Android Studio](https://goo.gl/XxQghQ) which will install the Android SDK as well, usually under home, like: `~/Android/Sdk`.
1. Set an environment variable for it: `export ANDROID_HOME=~/Android/Sdk`
1. Download [NDK 21](https://developer.android.com/ndk/downloads/) and put to `$ANDROID_HOME/ndk`

#### Setup Rust Targets for Cross-Platform Compilation

```bash
$ rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android aarch64-apple-ios
```

### Rust SDK

We use a Rust SDK backend for various tasks. To be able to use it, we have to have a dyamic library 
built out from it which is then included in to the application bundle (such as apk).

To achieve this, one must follow the steps below.

#### 1. Update Rust Code

As the Rust code is included in this repository as a git submodule, you have to sync it.

```bash
# Note: run it in this repository's root.
$ git submodule update --init --recursive --remote
```

#### 2. Build Dynamic Library Files

Here, you only have to run one script, which will does two things:
* it will build all cross-platform libraries we support and
* it will copy these artifacts to the right place. 

```bash
$ ./build-libraries.sh
```

# TODO

## More platforms

TODO: add more platforms beside x86_64, consider using other ios targets as well
https://i.stack.imgur.com/jKZE4.png

## Cargo Config

This must be in the cargo config to be able to cross compile everything. Needs more investigation:
```bash
[target.x86_64-linux-android]
ar = "~/Android/Sdk/ndk/20.1.5948944/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android-ar"
linker = "~/Android/Sdk/ndk/20.1.5948944/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android29-clang"

[target.aarch64-linux-android]
ar = "/home/mudlee/Android/Sdk/ndk/20.1.5948944/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android29-ar"
linker = "/home/mudlee/Android/Sdk/ndk/20.1.5948944/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android29-clang"
```