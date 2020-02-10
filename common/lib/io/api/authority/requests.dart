import 'package:json_annotation/json_annotation.dart';

part 'requests.g.dart';

@JsonSerializable()
class WitnessRequestsResponse {
  final List<WitnessRequestWithMetaData> requests;

  WitnessRequestsResponse(this.requests);

  factory WitnessRequestsResponse.fromJson(Map<String, dynamic> json) => _$WitnessRequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestsResponseToJson(this);
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
class WitnessRequestWithMetaData {
  final String hashlink;
  final WitnessRequestMetaData metadata;

  WitnessRequestWithMetaData(this.hashlink, this.metadata);

  factory WitnessRequestWithMetaData.fromJson(Map<String, dynamic> json) => _$WitnessRequestWithMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestWithMetaDataToJson(this);
}

@JsonSerializable()
class WitnessRequestMetaData {
  final int dateOfRequest;
  final RequestStatus status;
  final String process;

  WitnessRequestMetaData(this.dateOfRequest, this.status, this.process);

  factory WitnessRequestMetaData.fromJson(Map<String, dynamic> json) => _$WitnessRequestMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestMetaDataToJson(this);
}

@JsonSerializable()
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

enum RequestStatus {
  PENDING,
  APPROVED,
  DENIED,
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