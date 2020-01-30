import 'dart:convert';

import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/io/url_fetcher.dart';

class AuthorityApi {
  static AuthorityApi _instance;
  final String _apiUrl;

  AuthorityApi(this._apiUrl);

  static AuthorityApi get instance => _instance == null ? throw Exception('AuthorityApi is no yet set') : _instance;

  static AuthorityApi setAsEmulator() => _instance = AuthorityApi('http://10.0.2.2:8080');

  static AuthorityApi setAsRealDevice(url) => _instance = AuthorityApi(url);

  Future<List<Process>> getProcesses() async {
    return UrlFetcher
      .fetch('$_apiUrl/processes')
      .then((respJson) =>
        ProcessResponse
          .fromJson(json.decode(respJson))
          .processes
      );
  }

  Future<String> getBlob(String contentId) async {
    return UrlFetcher.fetch('$_apiUrl/blob/$contentId');
  }
}