import 'dart:ffi';
import 'dart:io';   // For Platform.isX

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

final DynamicLibrary nativeAddLib =
Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd =
nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

void main() => runApp(MyApp());

typedef NativeRustPingFunction = Pointer<Utf8> Function(Pointer<Utf8>);
typedef NativePingFunction = Pointer<Utf8> Function(Pointer<Utf8>);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*const path = 'rust_c/target/debug/librust_integration_test.so';
    DynamicLibrary dl = DynamicLibrary.open(path);
    final ping = dl
        .lookup<NativeFunction<NativeRustPingFunction>>('ping')
        .asFunction<NativePingFunction>();

    print(Utf8.fromUtf8(ping(Utf8.toUtf8("FROM_DART").cast())));*/
    print(nativeAdd(1, 2));


    return MaterialApp(
      title: 'Morpheus KYC PoC',
      theme: ThemeData(
        primarySwatch: primaryMaterialColor,
      ),
      home: HomePage(),
    );
  }
}
