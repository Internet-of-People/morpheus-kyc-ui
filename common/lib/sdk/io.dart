import 'package:json_annotation/json_annotation.dart';

part 'io.g.dart';

enum RequestStatus {
  pending,
  approved,
  rejected,
}

abstract class Signed {
  final Signature signature;

  Signed(this.signature);
}

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
class SignedWitnessRequest extends Signed {
  final WitnessRequest content;

  SignedWitnessRequest(this.content, Signature signature) : super(signature);

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
class SignedWitnessStatement extends Signed {
  final WitnessStatement content;

  SignedWitnessStatement(this.content, Signature signature): super(signature);

  factory SignedWitnessStatement.fromJson(Map<String, dynamic> json) => _$SignedWitnessStatementFromJson(json);

  Map<String, dynamic> toJson() => _$SignedWitnessStatementToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProvenClaim {
  final Claim claim;
  final List<SignedWitnessStatement> statements;

  ProvenClaim(this.claim, this.statements);

  factory ProvenClaim.fromJson(Map<String, dynamic> json) => _$ProvenClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ProvenClaimToJson(this);
}

@JsonSerializable(explicitToJson: true)
class License {
  final String issuedTo;
  final String purpose;
  final String expiry;

  License(this.issuedTo, this.purpose, this.expiry);

  factory License.fromJson(Map<String, dynamic> json) => _$LicenseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Presentation {
  final List<ProvenClaim> provenClaims;
  final List<License> licenses;

  Presentation(this.provenClaims, this.licenses);

  factory Presentation.fromJson(Map<String, dynamic> json) => _$PresentationFromJson(json);

  Map<String, dynamic> toJson() => _$PresentationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignedPresentation extends Signed {
  final Presentation content;

  SignedPresentation(this.content, Signature signature): super(signature);

  factory SignedPresentation.fromJson(Map<String, dynamic> json) => _$SignedPresentationFromJson(json);

  Map<String, dynamic> toJson() => _$SignedPresentationToJson(this);
}