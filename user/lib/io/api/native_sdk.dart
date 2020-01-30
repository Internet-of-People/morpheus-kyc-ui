import 'package:morpheus_dart/rust.dart' show RustAPI, RustSdk;

class NativeSDK {
  static RustSdk _instance;

  static RustSdk get instance {
    if(_instance == null) {
      _instance = RustAPI.initSdk('libmorpheus_sdk.so');
    }

    return _instance;
  }
}