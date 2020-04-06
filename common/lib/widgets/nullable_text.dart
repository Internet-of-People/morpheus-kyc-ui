import 'package:flutter/material.dart';

class NullableText extends StatelessWidget {
  final String text;
  final String ifNullText;
  final TextStyle style;

  const NullableText({
    Key key,
    this.text,
    this.ifNullText = '-',
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text ?? ifNullText, style: style);
  }
}