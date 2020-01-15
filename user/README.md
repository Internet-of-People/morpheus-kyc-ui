# morpheus_kyc_user

Morpheus KYC Demo - User

## Development

### Building JSON Factories

For more info visit:
- https://flutter.dev/docs/development/data-and-backend/json
- https://github.com/dart-lang/json_serializable/tree/master/example

```bash
$ flutter pub run build_runner build
```

### Rust Integration

TODO: add more platforms beside x86_64

Put cross compile settings into ~/.cargo/config
```bash
[target.x86_64-linux-android]
ar = "/home/mudlee/NDK/x86_64/bin/x86_64-linux-android-ar"
linker = "/home/mudlee/NDK/x86_64/bin/x86_64-linux-android-clang"
```

```
TODO
[target.armv7-linux-androideabi]
#ar = "/Users/andrei/projects/libertaria/nursery/connect-android/greetings/NDK/arm/bin/arm-linux-androideabi-ar"
#linker = "/Users/andrei/projects/libertaria/nursery/connect-android/greetings/NDK/arm/bin/arm-linux-androideabi-clang"
ar = "/Users/mudlee/Projects/iop/nursery/connect-android/NDK/arm/bin/arm-linux-androideabi-ar"
linker = "/Users/mudlee/Projects/iop/nursery/connect-android/NDK/arm/bin/arm-linux-androideabi-clang"

[target.i686-linux-android]
#ar = "/Users/andrei/projects/libertaria/nursery/connect-android/greetings/NDK/x86/bin/i686-linux-android-ar"
#linker = "/Users/andrei/projects/libertaria/nursery/connect-android/greetings/NDK/x86/bin/i686-linux-android-clang"
ar = "/Users/mudlee/Projects/iop/nursery/connect-android/NDK/x86/bin/i686-linux-android-ar"
linker = "/Users/mudlee/Projects/iop/nursery/connect-android/NDK/x86/bin/i686-linux-android-clang"
```

```bash
$ export ANDROID_HOME=~/Android/Sdk # this might vary
$ export NDK_HOME=$ANDROID_HOME/ndk-bundle
```

```bash
$ mkdir NDK # TODO: move it under Sdk somewhere
$ ${NDK_HOME}/build/tools/make_standalone_toolchain.py --api 26 --arch arm64 --install-dir NDK/arm64 
$ ${NDK_HOME}/build/tools/make_standalone_toolchain.py --api 26 --arch arm --install-dir NDK/arm 
$ ${NDK_HOME}/build/tools/make_standalone_toolchain.py --api 26 --arch x86 --install-dir NDK/x86
$ ${NDK_HOME}/build/tools/make_standalone_toolchain.py --api 26 --arch x86_64 --install-dir NDK/x86_64
```

```bash
$ rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
```

```bash
cargo build --target aarch64-linux-android --release cargo build --target armv7-linux-androideabi --release cargo build --target i686-linux-android --release --target x86_64-linux-android --release
```
