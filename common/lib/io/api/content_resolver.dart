import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/core/content.dart';

class ContentResolver {
  static Future<String> resolve(String source) async {
    final content = Content.parse(source);

    if(content.content.isPresent) {
      return content.content.value;
    }

    return await AuthorityApi.instance.getBlob(content.contentId.value);
  }
}