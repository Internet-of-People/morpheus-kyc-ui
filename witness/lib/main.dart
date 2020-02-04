import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morpheus_common/theme/theme.dart';
import 'package:witness/pages/home.dart';

void main() async {
  runApp(WitnessApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
}

class WitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Witness',
      theme: MorpheusTheme.theme,
      home: HomePage(),
    );
  }
}