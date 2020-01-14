import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morpheus KYC PoC',
      theme: ThemeData(
        primarySwatch: primaryMaterialColor,
      ),
      home: HomePage(),
    );
  }
}
