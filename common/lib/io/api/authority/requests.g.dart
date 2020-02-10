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
            : WitnessRequestWithMetaData.fromJson(e as Map<String, dynamic>))
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
        : SignedStatement.fromJson(
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
  RequestStatus.PENDING: 'PENDING',
  RequestStatus.APPROVED: 'APPROVED',
  RequestStatus.REJECTED: 'REJECTED',
};

WitnessRequestWithMetaData _$WitnessRequestWithMetaDataFromJson(
    Map<String, dynamic> json) {
  return WitnessRequestWithMetaData(
    json['hashlink'] as String,
    json['metadata'] == null
        ? null
        : WitnessRequestMetaData.fromJson(
            json['metadata'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WitnessRequestWithMetaDataToJson(
        WitnessRequestWithMetaData instance) =>
    <String, dynamic>{
      'hashlink': instance.hashlink,
      'metadata': instance.metadata?.toJson(),
    };

WitnessRequestMetaData _$WitnessRequestMetaDataFromJson(
    Map<String, dynamic> json) {
  return WitnessRequestMetaData(
    json['dateOfRequest'] as int,
    _$enumDecodeNullable(_$RequestStatusEnumMap, json['status']),
    json['process'] as String,
  );
}

Map<String, dynamic> _$WitnessRequestMetaDataToJson(
        WitnessRequestMetaData instance) =>
    <String, dynamic>{
      'dateOfRequest': instance.dateOfRequest,
      'status': _$RequestStatusEnumMap[instance.status],
      'process': instance.process,
    };
