//import 'package:morpheus_kyc_user/sdk/api.dart';

import 'package:morpheus_dart/rust.dart' show RustAPI;


void main() async {
  /*final pingResult = await apiPing('ping param');
  print('Result $pingResult');

  final didsResult = await listDids();
  print(didsResult);*/

  RustAPI.initSdk('morpheus-rust/target/debug/libmorpheus_sdk.so');
}
