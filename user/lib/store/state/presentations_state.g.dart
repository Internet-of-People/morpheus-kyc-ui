// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentations_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresentationsState _$PresentationsStateFromJson(Map<String, dynamic> json) {
  return PresentationsState(
    (json['presentations'] as List)
        ?.map((e) => e == null
            ? null
            : CreatedPresentation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PresentationsStateToJson(PresentationsState instance) =>
    <String, dynamic>{
      'presentations':
          instance.presentations?.map((e) => e?.toJson())?.toList(),
    };

CreatedPresentation _$CreatedPresentationFromJson(Map<String, dynamic> json) {
  return CreatedPresentation(
    json['presentation'] == null
        ? null
        : SignedPresentation.fromJson(
            json['presentation'] as Map<String, dynamic>),
    json['dataToBeShared'] as Map<String, dynamic>,
    json['scenarioName'] as String,
    json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    json['url'] as String,
  );
}

Map<String, dynamic> _$CreatedPresentationToJson(
        CreatedPresentation instance) =>
    <String, dynamic>{
      'presentation': instance.presentation?.toJson(),
      'dataToBeShared': instance.dataToBeShared,
      'scenarioName': instance.scenarioName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'url': instance.url,
    };
