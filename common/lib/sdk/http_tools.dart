import 'package:http/http.dart' as http;
import 'package:morpheus_common/utils/log.dart';

class HttpTools {
  static Log _log = Log(HttpTools);

  static Future<String> httpPost(String url, dynamic body, int expectedStatus) async {
    _log.debug('POST $url...');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        },
        body: body
      );
      _log.debug('Status code: ${response.statusCode} $url');

      if (response.statusCode == expectedStatus) {
        return response.body;
      }
      else {
        throw Exception(
            'Status code does not match. Expected: $expectedStatus got: ${response.statusCode} $url BODY: ${response.body}'
        );
      }
    } catch (e) {
      _log.debug(e.toString());
      throw Exception('Error while pushing to $url. Reason: $e');
    }
  }

  static Future<String> httpGet(String url) async {
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