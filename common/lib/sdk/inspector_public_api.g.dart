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
