import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/home.dart';
import 'package:morpheus_kyc_user/morpheus-color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: PRIMARY_MATERIAL_COLOR,
      ),
      home: HomePage(),
    );
  }
}
