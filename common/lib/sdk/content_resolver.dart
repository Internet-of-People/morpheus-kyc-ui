import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_common/sdk/content.dart';

class ContentResolver {
  static Future<String> resolve(String source) async {
    final content = Content.parse(source);

    if(content.content.isPresent) {
      return content.content.value;
    }

    return await AuthorityPublicApi.instance.getPublicBlob(content.contentId.value);
  }
}