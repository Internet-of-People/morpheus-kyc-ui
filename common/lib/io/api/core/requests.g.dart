// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WitnessRequest _$WitnessRequestFromJson(Map<String, dynamic> json) {
  return WitnessRequest(
    json['claim'] == null
        ? null
        : Claim.fromJson(json['claim'] as Map<String, dynamic>),
    json['claimant'] as String,
    json['processId'] as String,
    json['evidence'] as Map<String, dynamic>,
    json['nonce'] as String,
  );
}

Map<String, dynamic> _$WitnessRequestToJson(WitnessRequest instance) =>
    <String, dynamic>{
      'claim': instance.claim?.toJson(),
      'claimant': instance.claimant,
      'processId': instance.processId,
      'evidence': instance.evidence,
      'nonce': instance.nonce,
    };

SignedWitnessRequest _$SignedWitnessRequestFromJson(Map<String, dynamic> json) {
  return SignedWitnessRequest(
    json['content'] == null
        ? null
        : WitnessRequest.fromJson(json['content'] as Map<String, dynamic>),
    json['signature'] == null
        ? null
        : Signature.fromJson(json['signature'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignedWitnessRequestToJson(
        SignedWitnessRequest instance) =>
    <String, dynamic>{
      'content': instance.content?.toJson(),
      'signature': instance.signature?.toJson(),
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

Signature _$SignatureFromJson(Map<String, dynamic> json) {
  return Signature(
    json['publicKey'] as String,
    json['bytes'] as String,
  );
}

Map<String, dynamic> _$SignatureToJson(Signature instance) => <String, dynamic>{
      'publicKey': instance.publicKey,
      'bytes': instance.bytes,
    };

WitnessStatement _$WitnessStatementFromJson(Map<String, dynamic> json) {
  return WitnessStatement(
    json['claim'] == null
        ? null
        : Claim.fromJson(json['claim'] as Map<String, dynamic>),
    json['processId'] as String,
    json['constraints'] == null
        ? null
        : WitnessStatementConstraints.fromJson(
            json['constraints'] as Map<String, dynamic>),
    json['nonce'] as String,
  );
}

Map<String, dynamic> _$WitnessStatementToJson(WitnessStatement instance) =>
    <String, dynamic>{
      'claim': instance.claim?.toJson(),
      'processId': instance.processId,
      'constraints': instance.constraints?.toJson(),
      'nonce': instance.nonce,
    };

WitnessStatementConstraints _$WitnessStatementConstraintsFromJson(
    Map<String, dynamic> json) {
  return WitnessStatementConstraints(
    json['after'] == null ? null : DateTime.parse(json['after'] as String),
    json['before'] == null ? null : DateTime.parse(json['before'] as String),
    json['witness'] as String,
    json['authority'] as String,
    json['content'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$WitnessStatementConstraintsToJson(
        WitnessStatementConstraints instance) =>
    <String, dynamic>{
      'after': instance.after?.toIso8601String(),
      'before': instance.before?.toIso8601String(),
      'witness': instance.witness,
      'authority': instance.authority,
      'content': instance.content,
    };

SignedWitnessStatement _$SignedWitnessStatementFromJson(
    Map<String, dynamic> json) {
  return SignedWitnessStatement(
    json['content'] == null
        ? null
        : WitnessStatement.fromJson(json['content'] as Map<String, dynamic>),
    json['signature'] == null
        ? null
        : Signature.fromJson(json['signature'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignedWitnessStatementToJson(
        SignedWitnessStatement instance) =>
    <String, dynamic>{
      'content': instance.content?.toJson(),
      'signature': instance.signature?.toJson(),
    };
