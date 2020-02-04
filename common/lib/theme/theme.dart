import 'package:flutter/material.dart';

class MorpheusTheme {
  static const _colorCode = 0xff0cafa4;

  static ThemeData theme = ThemeData(
    primaryColor: Color(_colorCode),
    primarySwatch: MaterialColor(_colorCode, const {
      50: const Color(0xffa0f8f2),
      100: const Color(0xff88f7ef),
      200: const Color(0xff58f3e9),
      300: const Color(0xff28f0e3),
      400: const Color(0xff0fd7c9),
      500: const Color(_colorCode),
      600: const Color(0xff0a8f86),
      700: const Color(0xff087770),
      800: const Color(0xff075f59),
      900: const Color(0xff054843)
    }),
  );
}