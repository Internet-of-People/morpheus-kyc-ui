import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef NativeRustPingFunction = Pointer<Utf8> Function(Pointer<Utf8>);
typedef NativePingFunction = Pointer<Utf8> Function(Pointer<Utf8>);

void main(){
  const path = 'rust_c/target/debug/librust_integration_test.so';
  DynamicLibrary dl = DynamicLibrary.open(path);
  final ping = dl
      .lookup<NativeFunction<NativeRustPingFunction>>('ping')
      .asFunction<NativePingFunction>();

  print(Utf8.fromUtf8(ping(Utf8.toUtf8("FROM_DART").cast())));
}