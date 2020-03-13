import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/sdk/content.dart';
import 'package:morpheus_common/sdk/http_tools.dart';
import 'package:morpheus_common/sdk/io.dart';

part 'authority_public_api.g.dart';

class AuthorityPublicApi {
  static AuthorityPublicApi _instance;
  final String _apiUrl;
  final String name;

  AuthorityPublicApi(this._apiUrl, this.name);

  static AuthorityPublicApi get instance => _instance == null ? throw Exception('AuthorityPublicApi is not yet set') : _instance;

  static AuthorityPublicApi setAsEmulator() => _instance = AuthorityPublicApi('http://${HttpTools.host}:8080', 'Government Office');

  static AuthorityPublicApi setAsRealDevice(url) => _instance = AuthorityPublicApi(url, 'Government Office');

  Future<ListProcessesResponse> listProcesses() async {
    return HttpTools.httpGet('$_apiUrl/processes')
      .then((respJson) =>
        ListProcessesResponse.fromJson(json.decode(respJson))
      );
  }

  Future<String> getPublicBlob(String contentId) async {
    return HttpTools.httpGet('$_apiUrl/blob/$contentId');
  }

  Future<SendRequestResponse> sendRequest(SignedWitnessRequest request) {
    return HttpTools.httpPost('$_apiUrl/requests', json.encode(request.toJson()), 202).then(
      (resp) => SendRequestResponse.fromJson(json.decode(resp))
    );
  }

  Future<RequestStatusResponse> getRequestStatus(String capabilityLink) {
    return HttpTools.httpGet('$_apiUrl/requests/$capabilityLink/status').then(
      (resp) => RequestStatusResponse.fromJson(json.decode(resp))
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ListProcessesResponse {
  final List<String> processes;

  ListProcessesResponse(this.processes);

  factory ListProcessesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListProcessesResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SendRequestResponse {
  final String capabilityLink;

  SendRequestResponse(this.capabilityLink);

  factory SendRequestResponse.fromJson(Map<String, dynamic> json) => _$SendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendRequestResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RequestStatusResponse {
  final RequestStatus status;
  final SignedWitnessStatement signedStatement;
  final String rejectionReason;

  RequestStatusResponse(this.status, this.signedStatement, this.rejectionReason);

  factory RequestStatusResponse.fromJson(Map<String, dynamic> json) => _$RequestStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStatusResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Process {
  final String name;
  final int version;
  final String description;
  final String claimSchema;
  final String evidenceSchema;
  final String constraintsSchema;

  Process(
    this.name,
    this.version,
    this.description,
    this.claimSchema,
    this.evidenceSchema,
    this.constraintsSchema,
  );

  Content get claimSchemaContent => Content.parse(this.claimSchema);

  Content get evidenceSchemaContent => Content.parse(this.evidenceSchema);

  Content get constraintsSchemaContent => Content.parse(this.constraintsSchema);

  factory Process.fromJson(Map<String, dynamic> json) => _$ProcessFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessToJson(this);
}
