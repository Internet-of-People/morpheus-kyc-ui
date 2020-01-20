import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

typedef rust_ping = Pointer<Utf8> Function(Pointer<Utf8>);
typedef Ping = Pointer<Utf8> Function(Pointer<Utf8>);

typedef rust_ping_callback = Void Function(Pointer<Utf8>, Int32, Pointer);
typedef PingCallback = void Function(Pointer<Utf8>, int, Pointer);


typedef rust_ping_delay = Pointer<Utf8> Function(Pointer<Utf8>, Int32);
typedef PingDelay = Pointer<Utf8> Function(Pointer<Utf8>, int);

typedef rust_ping_async = Void Function(Pointer<Utf8>, Int32, Pointer);
typedef PingAsync = void Function(Pointer<Utf8>, int, Pointer);

typedef Callback = Void Function(Pointer<Utf8>);

void callback(Pointer<Utf8> result){
  print(Utf8.fromUtf8(result));
}

const path = 'rust_c/target/release/libnative_add.so';
DynamicLibrary lib = DynamicLibrary.open(path);
final ping = lib
    .lookup<NativeFunction<rust_ping>>('ping')
    .asFunction<Ping>();

final pingCallback = lib
    .lookup<NativeFunction<rust_ping_callback>>('ping_callback')
    .asFunction<PingCallback>();

final pingAsync = lib
    .lookup<NativeFunction<rust_ping_async>>('ping_async')
    .asFunction<PingAsync>();

final pingDelay = lib
    .lookup<NativeFunction<rust_ping_delay>>('ping_async_blocking')
    .asFunction<PingDelay>();

void main() async {
  //print(Utf8.fromUtf8(ping(Utf8.toUtf8("Blocking ping from Dart").cast())));
  //print(Utf8.fromUtf8(pingDelay(Utf8.toUtf8("Different blocking ping from Dart").cast(), 2)));

  /*pingAsync(
      Utf8.toUtf8("Fully async ping from Dart").cast(),
      3,
      Pointer.fromFunction<Callback>(callback)
  );

  pingCallback(
      Utf8.toUtf8("Sync with callback").cast(),
      3,
      Pointer.fromFunction<Callback>(callback)
  );*/

  final result = await PingSDK('YOYO').call();
  print('Result of ping: $result');
  print('DONE');
  // TODO: why the app hangs still? even the isolate I started exists
}


class IsolateParams {
  final port;
  final String message;

  IsolateParams(this.port, this.message);
}

class PingSDK {
  final String _message;

  PingSDK(this._message);

  Future<String> call() async {
    final completer = Completer<String>();
    final receiver = ReceivePort();

    print('Listening...');
    receiver.listen((response) {
      print('Completing...');
      completer.complete(response);
    });

    print('Spawning isolate');
    final isolate = await Isolate.spawn(isolateFunc, IsolateParams(receiver.sendPort, _message));
    final exitListener = ReceivePort();
    exitListener.listen((event){
      print('EXIT');
      isolate.kill(priority: Isolate.immediate);
    });
    isolate.addOnExitListener(exitListener.sendPort);

    print('Returning future');
    return completer.future;
  }

  static void callbackLocal(Pointer<Utf8> result){
    print(Utf8.fromUtf8(result));
  }

  static void isolateFunc(IsolateParams params){
    String result;

    print('Running isolate func...');
    pingCallback(
        Utf8.toUtf8(params.message).cast(),
        2,
        // TODO: only static callbacks are accepted :-O
        // How can we set the result properly then?
        Pointer.fromFunction<Callback>(callbackLocal)
    );
    print('Isolate finished');
    params.port.send(result);
    print('Isolate func sent to port');
  }
}