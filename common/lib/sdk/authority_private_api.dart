import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/sdk/http_tools.dart';
import 'package:morpheus_common/sdk/io.dart';

part 'authority_private_api.g.dart';

class AuthorityPrivateApi {
  static AuthorityPrivateApi _instance;
  final String _apiUrl;
  final String name;

  AuthorityPrivateApi(this._apiUrl, this.name);

  static AuthorityPrivateApi get instance => _instance == null ? throw Exception('AuthorityPrivateApi is no yet set') : _instance;

  static AuthorityPrivateApi setAsEmulator() => _instance = AuthorityPrivateApi('http://10.0.2.2:8080', 'Government Office');

  static AuthorityPrivateApi setAsRealDevice(url) => _instance = AuthorityPrivateApi(url, 'Government Office');

  Future<ListRequestsResponse> listRequests() {
    return HttpTools.httpGet('$_apiUrl/requests').then(
      (resp) => ListRequestsResponse.fromJson(json.decode(resp))
    );
  }

  Future<String> getPrivateBlob(String contentId) async {
    return HttpTools.httpGet('$_apiUrl/private-blob/$contentId');
  }

  Future<void> approveRequest(String capabilityLink, SignedWitnessStatement statement) {
    return HttpTools.httpPost('$_apiUrl/requests/$capabilityLink/approve', json.encode(statement.toJson()), 200);
  }

  Future<void> rejectRequest(String capabilityLink, String rejectionReason) {
    return HttpTools.httpPost('$_apiUrl/requests/$capabilityLink/reject', json.encode({'rejectionReason':rejectionReason}), 200);
  }
}

@JsonSerializable(explicitToJson: true)
class ListRequestsResponse {
  final List<RequestEntry> requests;

  ListRequestsResponse(this.requests);

  factory ListRequestsResponse.fromJson(Map<String, dynamic> json) => _$ListRequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListRequestsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RequestEntry {
  final String capabilityLink;
  final String requestId;
  final DateTime dateOfRequest;
  final RequestStatus status;
  final String processId;
  final String notes;

  RequestEntry(this.capabilityLink, this.requestId, this.dateOfRequest, this.status, this.processId, this.notes);

  factory RequestEntry.fromJson(Map<String, dynamic> json) => _$RequestEntryFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEntryToJson(this);
}