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
      'signature': instance.signature?.toJson(),
      'statement': instance.statement,
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
