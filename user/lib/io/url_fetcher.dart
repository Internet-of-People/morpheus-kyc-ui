import 'package:http/http.dart' as http;
import 'package:morpheus_kyc_user/utils/log.dart';

class UrlFetcher {
  static Log _log = Log(UrlFetcher);

  static Future<String> fetch(String url) async {
    _log.debug('GET $url...');

    try {
      final response = await http.get(url);
      _log.debug('Status code: ${response.statusCode} $url');

      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        throw Exception(
            'Status code: ${response.statusCode} $url BODY: ${response.body}'
        );
      }
    } catch (e) {
      _log.debug(e.toString());
      throw Exception('Error while fetching $url. Reason: $e');
    }
  }
}
