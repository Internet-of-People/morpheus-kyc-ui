// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    activeDid: json['activeDid'] as String,
    requests: json['requests'] == null
        ? null
        : RequestsState.fromJson(json['requests'] as Map<String, dynamic>),
    presentations: json['presentations'] == null
        ? null
        : PresentationsState.fromJson(
            json['presentations'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'activeDid': instance.activeDid,
      'requests': instance.requests?.toJson(),
      'presentations': instance.presentations?.toJson(),
    };
