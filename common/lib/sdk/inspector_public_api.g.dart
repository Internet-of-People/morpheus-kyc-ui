// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspector_public_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListScenariosResponse _$ListScenariosResponseFromJson(
    Map<String, dynamic> json) {
  return ListScenariosResponse(
    (json['scenarios'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ListScenariosResponseToJson(
        ListScenariosResponse instance) =>
    <String, dynamic>{
      'scenarios': instance.scenarios,
    };

UploadPresentationResponse _$UploadPresentationResponseFromJson(
    Map<String, dynamic> json) {
  return UploadPresentationResponse(
    json['contentId'] as String,
  );
}

Map<String, dynamic> _$UploadPresentationResponseToJson(
        UploadPresentationResponse instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
    };

Prerequisite _$PrerequisiteFromJson(Map<String, dynamic> json) {
  return Prerequisite(
    json['process'] as String,
    (json['claimFields'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PrerequisiteToJson(Prerequisite instance) =>
    <String, dynamic>{
      'process': instance.process,
      'claimFields': instance.claimFields,
    };

Scenario _$ScenarioFromJson(Map<String, dynamic> json) {
  return Scenario(
    json['name'] as String,
    json['version'] as int,
    json['description'] as String,
    (json['prerequisites'] as List)
        ?.map((e) =>
            e == null ? null : Prerequisite.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['requiredLicenses'] as List)
        ?.map((e) => e == null
            ? null
            : LicenseSpecification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['resultSchema'] as String,
  );
}

Map<String, dynamic> _$ScenarioToJson(Scenario instance) => <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'description': instance.description,
      'prerequisites':
          instance.prerequisites?.map((e) => e?.toJson())?.toList(),
      'requiredLicenses':
          instance.requiredLicenses?.map((e) => e?.toJson())?.toList(),
      'resultSchema': instance.resultSchema,
    };
