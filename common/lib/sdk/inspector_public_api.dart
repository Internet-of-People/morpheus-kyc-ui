import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/sdk/http_tools.dart';
import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_common/utils/log.dart';

part 'inspector_public_api.g.dart';

class InspectorPublicApi {
  static Log _log = Log(InspectorPublicApi);
  static InspectorPublicApi _instance;
  final String _apiUrl;
  final String name;

  InspectorPublicApi(this._apiUrl, this.name);

  static InspectorPublicApi get instance => _instance == null ? throw Exception('InspectorPublicApi is no yet set') : _instance;

  static InspectorPublicApi setAsEmulator() => _instance = InspectorPublicApi('http://10.0.2.2:8080', 'Inspector');

  static InspectorPublicApi setAsRealDevice(url) => _instance = InspectorPublicApi(url, 'Inspector');

  Future<ListScenariosResponse> listScenarios() async {
    return HttpTools.httpGet('$_apiUrl/scenarios')
      .then((respJson) =>
        ListScenariosResponse.fromJson(json.decode(respJson))
      );
  }

  Future<String> getPublicBlob(String contentId) async {
    return HttpTools.httpGet('$_apiUrl/blob/$contentId');
  }

  Future<String> uploadPresentation(SignedPresentation presentation) async {
    return HttpTools.httpPost('$_apiUrl/presentation', json.encode(presentation.toJson()), 202);
  }
}

@JsonSerializable(explicitToJson: true)
class ListScenariosResponse {
  final List<String> scenarios;

  ListScenariosResponse(this.scenarios);

  factory ListScenariosResponse.fromJson(Map<String, dynamic> json) =>
      _$ListScenariosResponseFromJson(json);
}