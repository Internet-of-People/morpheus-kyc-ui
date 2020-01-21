import 'dart:async';
import 'dart:collection';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';

typedef _rust_ping_callback = Void Function(Pointer<Utf8>, Int32, Pointer, Pointer<Utf8>);
typedef _PingCallback = void Function(Pointer<Utf8>, int, Pointer, Pointer<Utf8>);
typedef _Callback = Void Function(Pointer<Utf8>, Pointer<Utf8>);

typedef _SDKCallback<P, R> = R Function(P message);

const path = 'rust_c/target/release/libnative_add.so';
DynamicLibrary lib = DynamicLibrary.open(path);

final pingCallback = lib
  .lookup<NativeFunction<_rust_ping_callback>>('ping_callback')
  .asFunction<_PingCallback>();


class RustAPI {
  static int _counter=0;
  static Map<String, String> _resultMap=HashMap();

  static void _callback(Pointer<Utf8> result, Pointer<Utf8> requestId){
    final id = Utf8.fromUtf8(requestId);

    if(_resultMap.containsKey(id)) {
      throw Exception('$id was already stored as a result');
    }

    _resultMap[id] = Utf8.fromUtf8(result);
  }

  static String ping(String message) {
    final id = (++_counter).toString();
    pingCallback(
      Utf8.toUtf8(message).cast(),
      2,
      Pointer.fromFunction<_Callback>(_callback),
      Utf8.toUtf8(id).cast(),
    );
    return _resultMap.remove(id);
  }
}

Future<String> apiPing(String message) async {
  return _RustAsyncCall<String, String>(message).call(RustAPI.ping);
}

/// This class is based on the compute method of package:flutter/foundation.dart
/// [P] is the param's and [R] is the return's type.
class _IsolateConfig<P, R> {
  final _SDKCallback<P, R> callback;
  final SendPort resultPort;
  final P param;

  _IsolateConfig(this.callback, this.resultPort, this.param);

  R apply() => callback(param);
}

class _RustAsyncCall<P, R> {
  final P _param;

  _RustAsyncCall(this._param);

  Future<R> call(_SDKCallback<P, R> callback) async {
    final ReceivePort resultPort = ReceivePort();
    final ReceivePort errorPort = ReceivePort();

    final isolate = await Isolate.spawn<_IsolateConfig<P, R>>(
        _isolateEntryPoint,
        _IsolateConfig(callback, resultPort.sendPort, _param),
        errorsAreFatal: true,
        onExit: resultPort.sendPort,
        onError: errorPort.sendPort
    );

    final result = Completer<R>();
    errorPort.listen((dynamic errorData){
      assert(errorData is List<dynamic>);
      assert(errorData.length == 2);
      final Exception exception = Exception(errorData[0]);
      final StackTrace stack = StackTrace.fromString(errorData[1]);
      if (result.isCompleted) {
        Zone.current.handleUncaughtError(exception, stack);
      } else {
        result.completeError(exception, stack);
      }
    });

    resultPort.listen((dynamic resultData) {
      assert(resultData == null || resultData is R);
      if (!result.isCompleted) {
        result.complete(resultData);
      }
    });

    await result.future;

    resultPort.close();
    errorPort.close();
    isolate.kill();

    return result.future;
  }
}

Future<void> _isolateEntryPoint<P, R>(_IsolateConfig<P, R> config) async {
  final result = config.apply();
  config.resultPort.send(result);
}

