import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:morpheus_common/io/api/authority/processes.dart';
import 'package:morpheus_common/io/api/authority/requests.dart';
import 'package:morpheus_common/io/api/core/requests.dart';
import 'package:morpheus_common/utils/log.dart';

class AuthorityApi {
  static Log _log = Log(AuthorityApi);
  static AuthorityApi _instance;
  final String _apiUrl;
  final String name;

  AuthorityApi(this._apiUrl, this.name);

  static AuthorityApi get instance => _instance == null ? throw Exception('AuthorityApi is no yet set') : _instance;

  static AuthorityApi setAsEmulator() => _instance = AuthorityApi('http://10.0.2.2:8080', 'Government Office');

  static AuthorityApi setAsRealDevice(url) => _instance = AuthorityApi(url, 'Government Office');

  Future<ProcessResponse> getProcesses() async {
    return _get('/processes')
      .then((respJson) =>
        ProcessResponse.fromJson(json.decode(respJson))
      );
  }

  Future<String> getBlob(String contentId) async {
    return _get('/blob/$contentId');
  }

  Future<String> getPrivateBlob(String contentId) async {
    return _get('/private-blob/$contentId');
  }

  Future<SendWitnessRequestResponse> sendWitnessRequest(SignedWitnessRequest request) {
    return _post('/requests', json.encode(request.toJson()), 202).then(
      (resp) => SendWitnessRequestResponse.fromJson(json.decode(resp))
    );
  }

  Future<RequestStatusResponse> checkRequestStatus(String capabilityLink) {
    return _get('/requests/$capabilityLink/status').then(
      (resp) => RequestStatusResponse.fromJson(json.decode(resp))
    );
  }

  Future<WitnessRequestsResponse> getWitnessRequests() {
    return _get('/requests').then(
      (resp) => WitnessRequestsResponse.fromJson(json.decode(resp))
    );
  }

  Future<void> approveRequest(String capabilityLink) {
    // TODO
  }

  Future<void> rejectRequest(String capabilityLink, String rejectionReason) {
    return _post('/requests/$capabilityLink/reject', json.encode({'rejectionReason':rejectionReason}), 200);
  }

  Future<String> _post(String url, dynamic body, int expectedStatus) async {
    print(body);
    _log.debug('POST $_apiUrl$url...');

    try {
      final response = await http.post(
        '$_apiUrl$url',
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

  Future<String> _get(String url) async {
    _log.debug('GET $_apiUrl$url...');

    try {
      final response = await http.get('$_apiUrl$url');
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