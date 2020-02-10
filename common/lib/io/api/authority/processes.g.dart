// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessResponse _$ProcessResponseFromJson(Map<String, dynamic> json) {
  return ProcessResponse(
    (json['processes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProcessResponseToJson(ProcessResponse instance) =>
    <String, dynamic>{
      'processes': instance.processes,
    };
