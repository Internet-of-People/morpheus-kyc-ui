import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/HomePage.dart';
import 'package:morpheus_kyc_user/utils/MorpheusColor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morpheus KYC PoC',
      theme: ThemeData(
        primarySwatch: PRIMARY_MATERIAL_COLOR,
      ),
      home: HomePage(),
    );
  }
}
