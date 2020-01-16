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

  print(Utf8.fromUtf8(ping(Utf8.toUtf8("FROM_DART").cast())));

  pingAsync(
      Utf8.toUtf8("FROM_DART_ASYNC").cast(),
      Pointer.fromFunction<Callback>(callback)
  );
}