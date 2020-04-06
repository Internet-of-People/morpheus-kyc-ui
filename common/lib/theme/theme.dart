import 'package:flutter/material.dart';

class MorpheusTheme {
  static const _colorCode = 0xff0cafa4;

  static ThemeData theme = ThemeData(
    primaryColor: Color(_colorCode),
    primarySwatch: MaterialColor(_colorCode, const {
      50: Color(0xffa0f8f2),
      100: Color(0xff88f7ef),
      200: Color(0xff58f3e9),
      300: Color(0xff28f0e3),
      400: Color(0xff0fd7c9),
      500: Color(_colorCode),
      600: Color(0xff0a8f86),
      700: Color(0xff087770),
      800: Color(0xff075f59),
      900: Color(0xff054843)
    }),
  );
}