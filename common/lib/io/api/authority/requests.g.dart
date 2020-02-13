// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WitnessRequestsResponse _$WitnessRequestsResponseFromJson(
    Map<String, dynamic> json) {
  return WitnessRequestsResponse(
    (json['requests'] as List)
        ?.map((e) => e == null
            ? null
            : WitnessRequestStatus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WitnessRequestsResponseToJson(
        WitnessRequestsResponse instance) =>
    <String, dynamic>{
      'requests': instance.requests?.map((e) => e?.toJson())?.toList(),
    };

RequestStatusResponse _$RequestStatusResponseFromJson(
    Map<String, dynamic> json) {
  return RequestStatusResponse(
    _$enumDecodeNullable(_$RequestStatusEnumMap, json['status']),
    json['signedStatement'] == null
        ? null
        : SignedWitnessStatement.fromJson(
            json['signedStatement'] as Map<String, dynamic>),
    json['rejectionReason'] as String,
  );
}

Map<String, dynamic> _$RequestStatusResponseToJson(
        RequestStatusResponse instance) =>
    <String, dynamic>{
      'status': _$RequestStatusEnumMap[instance.status],
      'signedStatement': instance.signedStatement?.toJson(),
      'rejectionReason': instance.rejectionReason,
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

WitnessRequestStatus _$WitnessRequestStatusFromJson(Map<String, dynamic> json) {
  return WitnessRequestStatus(
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

Map<String, dynamic> _$WitnessRequestStatusToJson(
        WitnessRequestStatus instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink,
      'requestId': instance.requestId,
      'dateOfRequest': instance.dateOfRequest?.toIso8601String(),
      'status': _$RequestStatusEnumMap[instance.status],
      'processId': instance.processId,
      'notes': instance.notes,
    };

SendWitnessRequestResponse _$SendWitnessRequestResponseFromJson(
    Map<String, dynamic> json) {
  return SendWitnessRequestResponse(
    json['capabilityLink'] as String,
  );
}

Map<String, dynamic> _$SendWitnessRequestResponseToJson(
        SendWitnessRequestResponse instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink,
    };
