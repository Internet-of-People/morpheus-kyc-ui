import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef rust_ping = Pointer<Utf8> Function(Pointer<Utf8>);
typedef Ping = Pointer<Utf8> Function(Pointer<Utf8>);

typedef rust_ping_async = Void Function(Pointer<Utf8>, Pointer);
typedef PingAsync = void Function(Pointer<Utf8>, Pointer);

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

  final pingAsyncBlocking = lib
      .lookup<NativeFunction<rust_ping>>('ping_async_blocking')
      .asFunction<Ping>();

  print(Utf8.fromUtf8(ping(Utf8.toUtf8("Blocking ping from Dart").cast())));
  print(Utf8.fromUtf8(pingAsyncBlocking(Utf8.toUtf8("Different blocking ping from Dart").cast())));

  pingAsync(
      Utf8.toUtf8("Fully async ping from Dart").cast(),
      Pointer.fromFunction<Callback>(callback)
  );
}
