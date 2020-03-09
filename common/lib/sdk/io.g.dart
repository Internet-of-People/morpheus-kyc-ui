// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'io.dart';

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
      'signature': instance.signature?.toJson(),
      'content': instance.content?.toJson(),
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
      'signature': instance.signature?.toJson(),
      'content': instance.content?.toJson(),
    };

ProvenClaim _$ProvenClaimFromJson(Map<String, dynamic> json) {
  return ProvenClaim(
    json['claim'] == null
        ? null
        : Claim.fromJson(json['claim'] as Map<String, dynamic>),
    (json['statements'] as List)
        ?.map((e) => e == null
            ? null
            : SignedWitnessStatement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProvenClaimToJson(ProvenClaim instance) =>
    <String, dynamic>{
      'claim': instance.claim?.toJson(),
      'statements': instance.statements?.map((e) => e?.toJson())?.toList(),
    };

License _$LicenseFromJson(Map<String, dynamic> json) {
  return License(
    json['issuedTo'] as String,
    json['purpose'] as String,
    json['expiry'] == null ? null : DateTime.parse(json['expiry'] as String),
  );
}

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'issuedTo': instance.issuedTo,
      'purpose': instance.purpose,
      'expiry': instance.expiry?.toIso8601String(),
    };

Presentation _$PresentationFromJson(Map<String, dynamic> json) {
  return Presentation(
    (json['provenClaims'] as List)
        ?.map((e) =>
            e == null ? null : ProvenClaim.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['licenses'] as List)
        ?.map((e) =>
            e == null ? null : License.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PresentationToJson(Presentation instance) =>
    <String, dynamic>{
      'provenClaims': instance.provenClaims?.map((e) => e?.toJson())?.toList(),
      'licenses': instance.licenses?.map((e) => e?.toJson())?.toList(),
    };

SignedPresentation _$SignedPresentationFromJson(Map<String, dynamic> json) {
  return SignedPresentation(
    json['content'] == null
        ? null
        : Presentation.fromJson(json['content'] as Map<String, dynamic>),
    json['signature'] == null
        ? null
        : Signature.fromJson(json['signature'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignedPresentationToJson(SignedPresentation instance) =>
    <String, dynamic>{
      'signature': instance.signature?.toJson(),
      'content': instance.content?.toJson(),
    };
