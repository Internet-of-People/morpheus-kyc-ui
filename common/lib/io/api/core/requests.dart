import 'package:json_annotation/json_annotation.dart';

part 'requests.g.dart';

@JsonSerializable(explicitToJson: true)
class WitnessRequest {
  final Claim claim;
  final String claimant;
  final String processId;
  final Map<String, dynamic> evidence;
  final String nonce;

  WitnessRequest(this.claim, this.claimant, this.processId, this.evidence, this.nonce);

  factory WitnessRequest.fromJson(Map<String, dynamic> json) => _$WitnessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignedWitnessRequest {
  final WitnessRequest content;
  final Signature signature;

  SignedWitnessRequest(this.content, this.signature);

  factory SignedWitnessRequest.fromJson(Map<String, dynamic> json) => _$SignedWitnessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignedWitnessRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Claim {
  final String subject;
  final Map<String, dynamic> content;

  Claim(this.subject, this.content);

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);
}

enum RequestStatus {
  pending,
  approved,
  rejected,
}

@JsonSerializable(explicitToJson: true)
class Signature {
  final String publicKey;
  final String bytes;

  Signature(this.publicKey, this.bytes);

  factory Signature.fromJson(Map<String, dynamic> json) => _$SignatureFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WitnessStatement {
  final Claim claim;
  final String processId;
  final WitnessStatementConstraints constraints;
  final String nonce;

  WitnessStatement(this.claim, this.processId, this.constraints, this.nonce);

  factory WitnessStatement.fromJson(Map<String, dynamic> json) => _$WitnessStatementFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessStatementToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WitnessStatementConstraints {
  final DateTime after;
  final DateTime before;
  final String witness; // KeyLink
  final String authority; // DID
  final Map<String, dynamic> content;

  WitnessStatementConstraints(this.after, this.before, this.witness, this.authority, this.content);

  factory WitnessStatementConstraints.fromJson(Map<String, dynamic> json) => _$WitnessStatementConstraintsFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessStatementConstraintsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignedWitnessStatement  {
  final WitnessStatement content;
  final Signature signature;

  SignedWitnessStatement(this.content, this.signature);

  factory SignedWitnessStatement.fromJson(Map<String, dynamic> json) => _$SignedWitnessStatementFromJson(json);

  Map<String, dynamic> toJson() => _$SignedWitnessStatementToJson(this);
}