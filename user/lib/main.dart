import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

/*final DynamicLibrary nativeAddLib =
Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();*/

void main() => runApp(KYCApp());

typedef NativeRustPingFunction = Pointer<Utf8> Function(Pointer<Utf8>);
typedef NativePingFunction = Pointer<Utf8> Function(Pointer<Utf8>);

class KYCApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*final ping = nativeAddLib
        .lookup<NativeFunction<NativeRustPingFunction>>('ping')
        .asFunction<NativePingFunction>();

    print(Utf8.fromUtf8(ping(Utf8.toUtf8("FROM_DART").cast())));*/

    return MaterialApp(
      title: 'Morpheus KYC PoC',
      theme: ThemeData(
        primarySwatch: primaryMaterialColor,
      ),
      home: HomePage(),
    );
  }
}
