import 'package:json_annotation/json_annotation.dart';

part 'witness_request.g.dart';

@JsonSerializable()
class WitnessRequest {
  final Claim claim;
  final Claimant claimant;
  final String process;
  final Map<String, dynamic> evidence;
  final String nonce;

  WitnessRequest(this.claim, this.claimant, this.process, this.evidence, this.nonce);

  factory WitnessRequest.fromJson(Map<String, dynamic> json) => _$WitnessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestToJson(this);
}

@JsonSerializable()
class SignedWitnessRequest {
  final String message;
  final String publicKey;
  final String signature;

  SignedWitnessRequest(this.message, this.publicKey, this.signature);

  factory SignedWitnessRequest.fromJson(Map<String, dynamic> json) => _$SignedWitnessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignedWitnessRequestToJson(this);
}

@JsonSerializable()
class Claim {
  final String subject;
  final Map<String, dynamic> content;

  Claim(this.subject, this.content);

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);
}

@JsonSerializable()
class Claimant {
  final String did;
  final String auth;

  Claimant(this.did, this.auth);

  factory Claimant.fromJson(Map<String, dynamic> json) => _$ClaimantFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimantToJson(this);
}

enum RequestStatus {
  PENDING,
  APPROVED,
  DENIED,
}

@JsonSerializable()
class RequestStatusResponse {
  final RequestStatus status;
  final SignedStatement signedStatement;

  RequestStatusResponse(this.status, this.signedStatement);

  factory RequestStatusResponse.fromJson(Map<String, dynamic> json) => _$RequestStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStatusResponseToJson(this);
}

@JsonSerializable()
class SignedStatement {
  final Signature signature;
  final dynamic statement;

  SignedStatement(this.signature, this.statement);

  factory SignedStatement.fromJson(Map<String, dynamic> json) => _$SignedStatementFromJson(json);

  Map<String, dynamic> toJson() => _$SignedStatementToJson(this);
}

@JsonSerializable()
class Signature {
  final String authentication;
  final String bytes;

  Signature(this.authentication, this.bytes);

  factory Signature.fromJson(Map<String, dynamic> json) => _$SignatureFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureToJson(this);
}