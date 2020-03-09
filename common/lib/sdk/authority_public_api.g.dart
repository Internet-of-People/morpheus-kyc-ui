// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authority_public_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProcessesResponse _$ListProcessesResponseFromJson(
    Map<String, dynamic> json) {
  return ListProcessesResponse(
    (json['processes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ListProcessesResponseToJson(
        ListProcessesResponse instance) =>
    <String, dynamic>{
      'processes': instance.processes,
    };

SendRequestResponse _$SendRequestResponseFromJson(Map<String, dynamic> json) {
  return SendRequestResponse(
    json['capabilityLink'] as String,
  );
}

Map<String, dynamic> _$SendRequestResponseToJson(
        SendRequestResponse instance) =>
    <String, dynamic>{
      'capabilityLink': instance.capabilityLink,
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

Process _$ProcessFromJson(Map<String, dynamic> json) {
  return Process(
    json['name'] as String,
    json['version'] as int,
    json['description'] as String,
    json['claimSchema'] as String,
    json['evidenceSchema'] as String,
    json['constraintsSchema'] as String,
  );
}

Map<String, dynamic> _$ProcessToJson(Process instance) => <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'description': instance.description,
      'claimSchema': instance.claimSchema,
      'evidenceSchema': instance.evidenceSchema,
      'constraintsSchema': instance.constraintsSchema,
    };
