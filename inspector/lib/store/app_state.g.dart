// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    url: json['url'] as String,
    presentationJson: json['presentationJson'] as String,
    presentation: json['presentation'] == null
        ? null
        : SignedPresentation.fromJson(
            json['presentation'] as Map<String, dynamic>),
    errors: (json['errors'] as List)?.map((e) => e as String)?.toList(),
    warnings: (json['warnings'] as List)?.map((e) => e as String)?.toList(),
    discount: json['discount'] as int,
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'url': instance.url,
      'presentationJson': instance.presentationJson,
      'presentation': instance.presentation?.toJson(),
      'errors': instance.errors,
      'warnings': instance.warnings,
      'discount': instance.discount,
    };
