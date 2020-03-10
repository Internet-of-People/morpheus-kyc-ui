// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestsState _$RequestsStateFromJson(Map<String, dynamic> json) {
  return RequestsState(
    (json['requests'] as List)
        ?.map((e) =>
            e == null ? null : SentRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RequestsStateToJson(RequestsState instance) =>
    <String, dynamic>{
      'requests': instance.requests?.map((e) => e?.toJson())?.toList(),
    };

SentRequest _$SentRequestFromJson(Map<String, dynamic> json) {
  return SentRequest(
    json['processName'] as String,
    json['processId'] as String,
    json['sentAt'] == null ? null : DateTime.parse(json['sentAt'] as String),
    json['authority'] as String,
    json['capabilityLink'] as String,
  );
}

Map<String, dynamic> _$SentRequestToJson(SentRequest instance) =>
    <String, dynamic>{
      'processName': instance.processName,
      'processId': instance.processId,
      'sentAt': instance.sentAt?.toIso8601String(),
      'authority': instance.authority,
      'capabilityLink': instance.capabilityLink,
    };
