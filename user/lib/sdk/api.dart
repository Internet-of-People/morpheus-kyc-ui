import 'dart:async';
import 'dart:collection';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:morpheus_kyc_user/sdk/ping.dart';

typedef _SDKCallback<P, R> = R Function(P message);

const path = 'rust_c/target/release/libnative_add.so';
DynamicLibrary lib = DynamicLibrary.open(path);

final pingCallback = lib.lookup<NativeFunction<NativeFuncPing>>('ping_callback').asFunction<DartFuncPing>();

class RustAPI {
  static int _counter=0;
  static final Map<String, dynamic> _resultMap=HashMap<String, dynamic>();

  static void _callback(Pointer<Utf8> result, Pointer<Utf8> requestId){
    final id = Utf8.fromUtf8(requestId);

    if(_resultMap.containsKey(id)) {
      throw Exception('$id was already stored as a result');
    }

    _resultMap[id] = result;
  }

  static _getNextId() {
    return (++_counter).toString();
  }

  static String ping(String message) {
    final id = _getNextId();
    pingCallback(
      Utf8.toUtf8(message).cast(),
      2,
      Pointer.fromFunction<DartFuncPingCallback>(_callback),
      Utf8.toUtf8(id).cast(),
    );
    return Utf8.fromUtf8(_resultMap.remove(id));
  }

  static List<String> listDids(_){
    final id = _getNextId();
    sleep(Duration(seconds: 2));
    _resultMap[id] = [Utf8.toUtf8('did:morpheus:ezFoo1'), Utf8.toUtf8('did:morpheus:ezFoo2')];
    return (_resultMap.remove(id) as List<Pointer<Utf8>>)
        .map((did)=>Utf8.fromUtf8(did))
        .toList();
  }
}

Future<String> apiPing(String message) async {
  return _RustAsyncCall<String, String>(message).call(RustAPI.ping);
}

Future<List<String>> listDids() async {
  return _RustAsyncCall<void, List<String>>(null).call(RustAPI.listDids);
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

