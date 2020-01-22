import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef NativeFuncPing = Void Function(Pointer<Utf8> message, Int32 delay, Pointer callback, Pointer<Utf8> requestId);
typedef DartFuncPing = void Function(Pointer<Utf8> message, int delay, Pointer callback, Pointer<Utf8> requestId);
typedef DartFuncPingCallback = Void Function(Pointer<Utf8> result, Pointer<Utf8> requestId);