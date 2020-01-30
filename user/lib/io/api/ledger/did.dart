import 'package:json_annotation/json_annotation.dart';

part 'did.g.dart';

@JsonSerializable()
class DIDDocument {
  final String did;
  final List<DIDKey> keys;
  final Map<DIDKeyRight, List<int>> rights;
  final int atHeight;
  final bool tombstoned;

  DIDDocument(this.did, this.keys, this.rights, this.atHeight, this.tombstoned);

  factory DIDDocument.fromJson(Map<String, dynamic> json) => _$DIDDocumentFromJson(json);
}

@JsonSerializable()
class DIDKey {
  final String auth;
  final int validFromHeight;
  final int validUntilHeight;
  final bool revoked;

  DIDKey(this.auth, this.validFromHeight, this.validUntilHeight, this.revoked);

  factory DIDKey.fromJson(Map<String, dynamic> json) => _$DIDKeyFromJson(json);
}

enum DIDKeyRight {
  impersonate,
  update
}