// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Process _$ProcessFromJson(Map<String, dynamic> json) {
  return Process(
    json['name'] as String,
    json['version'] as int,
    json['description'] as String,
    json['claimSchema'] as String,
    json['evidenceSchema'] as String,
    json['constraintsSchema'] as String,
  );
}

Map<String, dynamic> _$ProcessToJson(Process instance) => <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'description': instance.description,
      'claimSchema': instance.claimSchema,
      'evidenceSchema': instance.evidenceSchema,
      'constraintsSchema': instance.constraintsSchema,
    };
