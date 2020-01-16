import 'dart:convert';

import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/io/url_fetcher.dart';

class AuthorityApi {
  final String _apiUrl;

  AuthorityApi(this._apiUrl);

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