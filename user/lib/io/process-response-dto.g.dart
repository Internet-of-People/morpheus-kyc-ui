// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process-response-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessResponseDTO _$ProcessResponseDTOFromJson(Map<String, dynamic> json) {
  return ProcessResponseDTO(
    (json['processes'] as List)
        ?.map((e) =>
            e == null ? null : ProcessDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProcessResponseDTOToJson(ProcessResponseDTO instance) =>
    <String, dynamic>{
      'processes': instance.processes,
    };

ProcessDTO _$ProcessDTOFromJson(Map<String, dynamic> json) {
  return ProcessDTO(
    json['name'] as String,
    json['id'] as String,
    json['version'] as int,
    json['description'] as String,
    json['claimSchema'] as String,
    json['evidenceSchema'] as String,
    json['constraintsSchema'] as String,
  );
}

Map<String, dynamic> _$ProcessDTOToJson(ProcessDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'version': instance.version,
      'description': instance.description,
      'claimSchema': instance.claimSchema,
      'evidenceSchema': instance.evidenceSchema,
      'constraintsSchema': instance.constraintsSchema,
    };
