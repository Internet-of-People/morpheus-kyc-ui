import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/sdk/http_tools.dart';
import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_common/utils/log.dart';

part 'inspector_public_api.g.dart';

class InspectorPublicApi {
  static Log _log = Log(InspectorPublicApi);
  static InspectorPublicApi _instance;
  final String apiUrl;
  final String name;

  InspectorPublicApi(this.apiUrl, this.name);

  static InspectorPublicApi get instance => _instance == null ? throw Exception('InspectorPublicApi is no yet set') : _instance;

  static InspectorPublicApi setAsEmulator() => _instance = InspectorPublicApi('http://${HttpTools.host}:8081', 'Inspector');

  static InspectorPublicApi setAsRealDevice(url) => _instance = InspectorPublicApi(url, 'Inspector');

  Future<ListScenariosResponse> listScenarios() async {
    return HttpTools.httpGet('$apiUrl/scenarios')
      .then((respJson) =>
        ListScenariosResponse.fromJson(json.decode(respJson))
      );
  }

  Future<String> getPublicBlob(String contentId) async {
    return HttpTools.httpGet('$apiUrl/blob/$contentId');
  }

  Future<UploadPresentationResponse> uploadPresentation(SignedPresentation presentation) async {
    return HttpTools.httpPost('$apiUrl/presentation', json.encode(presentation.toJson()), 202)
      .then((resp) => UploadPresentationResponse.fromJson(json.decode(resp)));
  }
}

@JsonSerializable(explicitToJson: true)
class ListScenariosResponse {
  final List<String> scenarios;

  ListScenariosResponse(this.scenarios);

  factory ListScenariosResponse.fromJson(Map<String, dynamic> json) =>
      _$ListScenariosResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UploadPresentationResponse {
  final String contentId;

  UploadPresentationResponse(this.contentId);

  factory UploadPresentationResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadPresentationResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class Prerequisite {
  final String process;
  final List<String> claimFields;

  Prerequisite(this.process, this.claimFields);

  factory Prerequisite.fromJson(Map<String, dynamic> json) => _$PrerequisiteFromJson(json);

  Map<String, dynamic> toJson() => _$PrerequisiteToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Scenario {
  final String name;
  final int version;
  final String description;
  final List<Prerequisite> prerequisites;
  final List<LicenseSpecification> requiredLicenses;
  final String resultSchema;

  Scenario(this.name, this.version, this.description, this.prerequisites, this.requiredLicenses, this.resultSchema);

  factory Scenario.fromJson(Map<String, dynamic> json) => _$ScenarioFromJson(json);

  Map<String, dynamic> toJson() => _$ScenarioToJson(this);
}