// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authority_private_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequestsResponse _$ListRequestsResponseFromJson(Map<String, dynamic> json) {
  return ListRequestsResponse(
    (json['requests'] as List)
        ?.map((e) =>
            e == null ? null : RequestEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListRequestsResponseToJson(
        ListRequestsResponse instance) =>
    <String, dynamic>{
      'requests': instance.requests?.map((e) => e?.toJson())?.toList(),
    };

RequestEntry _$RequestEntryFromJson(Map<String, dynamic> json) {
  return RequestEntry(
    json['capabilityLink'] as String,
    json['requestId'] as String,
    json['dateOfRequest'] == null
        ? null
        : DateTime.parse(json['dateOfRequest'] as String),
    _$enumDecodeNullable(_$RequestStatusEnumMap, json['status']),
    json['processId'] as String,
    json['notes'] as String,
  );
}

Map<String, dynamic> _$RequestEntryToJson(RequestEntry instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink,
      'requestId': instance.requestId,
      'dateOfRequest': instance.dateOfRequest?.toIso8601String(),
      'status': _$RequestStatusEnumMap[instance.status],
      'processId': instance.processId,
      'notes': instance.notes,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$RequestStatusEnumMap = {
  RequestStatus.pending: 'pending',
  RequestStatus.approved: 'approved',
  RequestStatus.rejected: 'rejected',
};
