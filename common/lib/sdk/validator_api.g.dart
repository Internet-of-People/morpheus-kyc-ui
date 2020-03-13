// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validator_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationRequest _$ValidationRequestFromJson(Map<String, dynamic> json) {
  return ValidationRequest(
    json['onBehalfOf'] as String,
    json['auth'] as String,
    json['beforeProof'] as String,
    json['afterProof'] == null
        ? null
        : AfterProof.fromJson(json['afterProof'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValidationRequestToJson(ValidationRequest instance) =>
    <String, dynamic>{
      'onBehalfOf': instance.onBehalfOf,
      'auth': instance.auth,
      'beforeProof': instance.beforeProof,
      'afterProof': instance.afterProof?.toJson(),
    };

ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) {
  return ValidationResult(
    (json['errors'] as List)?.map((e) => e as String)?.toList(),
    (json['warnings'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ValidationResultToJson(ValidationResult instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'warnings': instance.warnings,
    };
