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
      'requests': instance.requests,
    };

RequestStatusResponse _$RequestStatusResponseFromJson(
    Map<String, dynamic> json) {
  return RequestStatusResponse(
    _$enumDecodeNullable(_$RequestStatusEnumMap, json['status']),
    json['signedStatement'] == null
        ? null
        : SignedStatement.fromJson(
            json['signedStatement'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestStatusResponseToJson(
        RequestStatusResponse instance) =>
    <String, dynamic>{
      'status': _$RequestStatusEnumMap[instance.status],
      'signedStatement': instance.signedStatement,
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
  RequestStatus.DENIED: 'DENIED',
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
      'metadata': instance.metadata,
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

WitnessRequest _$WitnessRequestFromJson(Map<String, dynamic> json) {
  return WitnessRequest(
    json['claim'] == null
        ? null
        : Claim.fromJson(json['claim'] as Map<String, dynamic>),
    json['claimant'] == null
        ? null
        : Claimant.fromJson(json['claimant'] as Map<String, dynamic>),
    json['process'] as String,
    json['evidence'] as Map<String, dynamic>,
    json['nonce'] as String,
  );
}

Map<String, dynamic> _$WitnessRequestToJson(WitnessRequest instance) =>
    <String, dynamic>{
      'claim': instance.claim,
      'claimant': instance.claimant,
      'process': instance.process,
      'evidence': instance.evidence,
      'nonce': instance.nonce,
    };

SignedWitnessRequest _$SignedWitnessRequestFromJson(Map<String, dynamic> json) {
  return SignedWitnessRequest(
    json['message'] as String,
    json['publicKey'] as String,
    json['signature'] as String,
  );
}

Map<String, dynamic> _$SignedWitnessRequestToJson(
        SignedWitnessRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'publicKey': instance.publicKey,
      'signature': instance.signature,
    };

Claim _$ClaimFromJson(Map<String, dynamic> json) {
  return Claim(
    json['subject'] as String,
    json['content'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'subject': instance.subject,
      'content': instance.content,
    };

Claimant _$ClaimantFromJson(Map<String, dynamic> json) {
  return Claimant(
    json['did'] as String,
    json['auth'] as String,
  );
}

Map<String, dynamic> _$ClaimantToJson(Claimant instance) => <String, dynamic>{
      'did': instance.did,
      'auth': instance.auth,
    };

SignedStatement _$SignedStatementFromJson(Map<String, dynamic> json) {
  return SignedStatement(
    json['signature'] == null
        ? null
        : Signature.fromJson(json['signature'] as Map<String, dynamic>),
    json['statement'],
  );
}

Map<String, dynamic> _$SignedStatementToJson(SignedStatement instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'statement': instance.statement,
    };

Signature _$SignatureFromJson(Map<String, dynamic> json) {
  return Signature(
    json['authentication'] as String,
    json['bytes'] as String,
  );
}

Map<String, dynamic> _$SignatureToJson(Signature instance) => <String, dynamic>{
      'authentication': instance.authentication,
      'bytes': instance.bytes,
    };
