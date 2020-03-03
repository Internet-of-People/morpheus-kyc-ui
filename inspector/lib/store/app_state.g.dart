// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    url: json['url'] as String,
    presentationJson: json['presentationJson'] as String,
    signatureErrors:
        (json['signatureErrors'] as List)?.map((e) => e as String)?.toList(),
    discount: json['discount'] as int,
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'url': instance.url,
      'presentationJson': instance.presentationJson,
      'signatureErrors': instance.signatureErrors,
      'discount': instance.discount,
    };
