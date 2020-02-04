import 'dart:async';

import 'package:flutter/services.dart';

class NativeSdk {
  static const MethodChannel _channel =
      const MethodChannel('native_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
