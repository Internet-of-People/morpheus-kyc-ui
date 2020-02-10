
import 'dart:convert';

import 'package:optional/optional.dart';

class Content {
  String _contentId;
  String _content;

  Content._();

  Content._internal();

  factory Content.parse(String source) {
    final content = Content._internal();
    try {
      json.decode(source);
      content._content = source;
    } on FormatException {
      content._contentId = source;
    } catch (e) {
      throw Exception('Could not parse Content. $e');
    }
    return content;
  }

  Optional<String> get contentId => Optional.ofNullable(_contentId);

  Optional<String> get content => Optional.ofNullable(_content);
}