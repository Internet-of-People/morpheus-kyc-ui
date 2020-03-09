import 'package:morpheus_common/sdk/authority_private_api.dart';
import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_common/sdk/content.dart';
import 'package:morpheus_common/sdk/inspector_public_api.dart';

enum ContentLocation {
  AUTHORITY_PUBLIC,
  AUTHORITY_PRIVATE,
  INSPECTOR_PUBLIC,
}

class ContentResolver {
  static Future<String> resolve(String source, ContentLocation location) async {
    final content = Content.parse(source);

    if(content.content.isPresent) {
      return content.content.value;
    }

    switch (location) {
      case ContentLocation.AUTHORITY_PUBLIC:
        return await AuthorityPublicApi.instance.getPublicBlob(content.contentId.value);
      case ContentLocation.AUTHORITY_PRIVATE:
        return await AuthorityPrivateApi.instance.getPrivateBlob(content.contentId.value);
      case ContentLocation.INSPECTOR_PUBLIC:
        return await InspectorPublicApi.instance.getPublicBlob(content.contentId.value);
      default:
        throw Exception('Invalid lication $location');
    }
  }

  static Future<Map<String, String>> resolveByContentIds(List<String> ids, ContentLocation location) async {
    List<Future<String>> contentResolvers = ids.map((id) async => await ContentResolver.resolve(id, location)).toList();
    final contents = await Future.wait(contentResolvers);

    Map<String, String> contentIdContentMap = Map();
    for(int i=0;i<contents.length;i++) {
      contentIdContentMap[ids[i]] = contents[i];
    }

    return contentIdContentMap;
  }
}