import 'package:json_annotation/json_annotation.dart';

part 'did.g.dart';

@JsonSerializable(explicitToJson: true)
class DIDDocument {
  final String did;
  final List<DIDKey> keys;
  final Map<RightType, List<DIDKeyRight>> rights;
  final int atHeight;
  final bool tombstoned;

  DIDDocument(this.did, this.keys, this.rights, this.atHeight, this.tombstoned);

  factory DIDDocument.fromJson(Map<String, dynamic> json) => _$DIDDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DIDDocumentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DIDKey {
  final int index;
  final String auth;
  final int validFromHeight;
  final int validUntilHeight;
  final bool valid;
  final bool tombstoned;
  final int tombstonedAtHeight;
  final int queriedAtHeight;

  DIDKey(
    this.index,
    this.auth,
    this.validFromHeight,
    this.validUntilHeight,
    this.valid,
    this.tombstoned,
    this.tombstonedAtHeight,
    this.queriedAtHeight
  );

  factory DIDKey.fromJson(Map<String, dynamic> json) => _$DIDKeyFromJson(json);

  Map<String, dynamic> toJson() => _$DIDKeyToJson(this);
}

enum RightType {
  impersonate,
  update
}

@JsonSerializable(explicitToJson: true)
class DIDKeyRight {
  final String keyLink;
  final List<DIDKeyRightHistory> history;
  final bool valid;

  DIDKeyRight(this.keyLink, this.history, this.valid);

  factory DIDKeyRight.fromJson(Map<String, dynamic> json) => _$DIDKeyRightFromJson(json);

  Map<String, dynamic> toJson() => _$DIDKeyRightToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DIDKeyRightHistory {
  final int height;
  final bool valid;

  DIDKeyRightHistory(this.height, this.valid);

  factory DIDKeyRightHistory.fromJson(Map<String, dynamic> json) => _$DIDKeyRightHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$DIDKeyRightHistoryToJson(this);
}