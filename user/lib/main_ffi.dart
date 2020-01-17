import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef rust_ping = Pointer<Utf8> Function(Pointer<Utf8>);
typedef Ping = Pointer<Utf8> Function(Pointer<Utf8>);

typedef rust_ping_delay = Pointer<Utf8> Function(Pointer<Utf8>, Int32);
typedef PingDelay = Pointer<Utf8> Function(Pointer<Utf8>, int);

typedef rust_ping_async = Void Function(Pointer<Utf8>, Int32, Pointer);
typedef PingAsync = void Function(Pointer<Utf8>, int, Pointer);

typedef Callback = Void Function(Pointer<Utf8>);

void callback(Pointer<Utf8> result){
  print(Utf8.fromUtf8(result));
}

void main(){
  const path = 'rust_c/target/release/libnative_add.so';
  DynamicLibrary lib = DynamicLibrary.open(path);
  final ping = lib
      .lookup<NativeFunction<rust_ping>>('ping')
      .asFunction<Ping>();

  final pingAsync = lib
      .lookup<NativeFunction<rust_ping_async>>('ping_async')
      .asFunction<PingAsync>();

  final pingDelay = lib
      .lookup<NativeFunction<rust_ping_delay>>('ping_async_blocking')
      .asFunction<PingDelay>();

  print(Utf8.fromUtf8(ping(Utf8.toUtf8("Blocking ping from Dart").cast())));
  print(Utf8.fromUtf8(pingDelay(Utf8.toUtf8("Different blocking ping from Dart").cast(), 2)));

  pingAsync(
      Utf8.toUtf8("Fully async ping from Dart").cast(),
      3,
      Pointer.fromFunction<Callback>(callback)
  );
  // TODO @mudlee transform callback into a Future and wait for it
}
