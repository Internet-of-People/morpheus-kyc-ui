import 'dart:convert';
import 'dart:typed_data';

import 'package:randombytes/randombytes.dart';

String nonce264() {
  Uint8List bytes = randomBytes(33);
  return 'u${base64Encode(bytes)}';
}