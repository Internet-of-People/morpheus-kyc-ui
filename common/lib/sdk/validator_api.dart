import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_common/sdk/http_tools.dart';

part 'validator_api.g.dart';

class ValidatorApi {
  static ValidatorApi _instance;
  final String _apiUrl;
  final String name;

  ValidatorApi(this._apiUrl, this.name);

  static ValidatorApi get instance => _instance == null ? throw Exception('ValidatorApi is not yet set') : _instance;

  static ValidatorApi setAsEmulator() => _instance = ValidatorApi('http://${HttpTools.host}:8081', 'Inspector');

  static ValidatorApi setAsRealDevice(url) => _instance = ValidatorApi(url, 'Inspector');

  Future<AfterProof> getAfterProof() async {
    final respJson = await HttpTools.httpGet('$_apiUrl/after-proof');
    return AfterProof.fromJson(json.decode(respJson));
  }

  Future<ValidationResult> validate(ValidationRequest request) async {
    final respJson = await HttpTools.httpPost('$_apiUrl/validate', json.encode(request.toJson()), 200);
    return ValidationResult.fromJson(json.decode(respJson));
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationRequest {
  /// Did
  final String onBehalfOf;
  /// AuthenticationData (KeyId or PublicKey serialized)
  final String auth;
  /// Option<ContentId>, bravely set to null
  final String beforeProof;
  /// Option<AfterProof>, bravely set to null
  final AfterProof afterProof;

  ValidationRequest(this.onBehalfOf, this.auth, this.beforeProof, this.afterProof);

  factory ValidationRequest.fromJson(Map<String, dynamic> json) => _$ValidationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ValidationResult {
  final List<String> errors;
  final List<String> warnings;

  ValidationResult(this.errors, this.warnings);

  factory ValidationResult.fromJson(Map<String, dynamic> json) => _$ValidationResultFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationResultToJson(this);
}
