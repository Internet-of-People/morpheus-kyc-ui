import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/io/api/authority/witness_request.dart';
import 'package:morpheus_kyc_user/utils/log.dart';

class AuthorityApi {
  static Log _log = Log(AuthorityApi);
  static AuthorityApi _instance;
  final String _apiUrl;

  AuthorityApi(this._apiUrl);

  static AuthorityApi get instance => _instance == null ? throw Exception('AuthorityApi is no yet set') : _instance;

  static AuthorityApi setAsEmulator() => _instance = AuthorityApi('http://10.0.2.2:8080');

  static AuthorityApi setAsRealDevice(url) => _instance = AuthorityApi(url);

  Future<List<Process>> getProcesses() async {
    return get('$_apiUrl/processes')
      .then((respJson) =>
        ProcessResponse
          .fromJson(json.decode(respJson))
          .processes
      );
  }

  Future<String> getBlob(String contentId) async {
    return get('$_apiUrl/blob/$contentId');
  }

  Future<String> sendWitnessRequest(String request) {
    return post('$_apiUrl/requests', request, 202);
  }

  Future<RequestStatusResponse> checkRequestStatus(String capabilityLink) {
    return get('$_apiUrl/requests/$capabilityLink/status').then(
        (resp) => RequestStatusResponse.fromJson(json.decode(resp))
    );
  }

  static Future<String> post(String url, dynamic body, int expectedStatus) async {
    _log.debug('POST $url...');

    try {
      final response = await http.post(url,body: body);
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

  static Future<String> get(String url) async {
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