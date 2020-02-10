import 'package:flutter_test/flutter_test.dart';
import 'package:morpheus_common/io/api/authority/content.dart';

void main() {
  test('Parses contentId', () {
    final content = Content.parse('Simple contentId');
    expect(content.contentId.isPresent, true);
    expect(content.content.isPresent, false);
    expect(content.contentId.value, 'Simple contentId');
  });

  test('Parses content', () {
    final content = Content.parse('{"thisis":"acontent"}');
    expect(content.contentId.isPresent, false);
    expect(content.content.isPresent, true);
    expect(content.content.value, Map.castFrom({'thisis':'acontent'}));
  });
}