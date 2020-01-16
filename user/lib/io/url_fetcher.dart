import 'package:http/http.dart' as http;
import 'package:morpheus_kyc_user/utils/log.dart';

class UrlFetcher {
  static Future<String> fetch(String url) async {
    Log.debug('GET $url...');

    try {
      final response = await http.get(url);
      Log.debug('Status code: ${response.statusCode} $url');

      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        throw Exception(
            'Status code: ${response.statusCode} $url BODY: ${response.body}'
        );
      }
    } catch (e) {
      Log.debug(e.toString());
      throw Exception('Error while fetching $url. Reason: $e');
    }
  }
}
