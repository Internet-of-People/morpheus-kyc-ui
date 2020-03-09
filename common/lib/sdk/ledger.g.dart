// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDDocument _$DIDDocumentFromJson(Map<String, dynamic> json) {
  return DIDDocument(
    json['did'] as String,
    (json['keys'] as List)
        ?.map((e) =>
            e == null ? null : DIDKey.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['rights'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          _$enumDecodeNullable(_$RightTypeEnumMap, k),
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : DIDKeyRight.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    ),
    json['atHeight'] as int,
    json['tombstoned'] as bool,
  );
}

Map<String, dynamic> _$DIDDocumentToJson(DIDDocument instance) =>
    <String, dynamic>{
      'did': instance.did,
      'keys': instance.keys?.map((e) => e?.toJson())?.toList(),
      'rights': instance.rights?.map((k, e) => MapEntry(
          _$RightTypeEnumMap[k], e?.map((e) => e?.toJson())?.toList())),
      'atHeight': instance.atHeight,
      'tombstoned': instance.tombstoned,
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

const _$RightTypeEnumMap = {
  RightType.impersonate: 'impersonate',
  RightType.update: 'update',
};

DIDKey _$DIDKeyFromJson(Map<String, dynamic> json) {
  return DIDKey(
    json['index'] as int,
    json['auth'] as String,
    json['validFromHeight'] as int,
    json['validUntilHeight'] as int,
    json['valid'] as bool,
    json['tombstoned'] as bool,
    json['tombstonedAtHeight'] as int,
    json['queriedAtHeight'] as int,
  );
}

Map<String, dynamic> _$DIDKeyToJson(DIDKey instance) => <String, dynamic>{
      'index': instance.index,
      'auth': instance.auth,
      'validFromHeight': instance.validFromHeight,
      'validUntilHeight': instance.validUntilHeight,
      'valid': instance.valid,
      'tombstoned': instance.tombstoned,
      'tombstonedAtHeight': instance.tombstonedAtHeight,
      'queriedAtHeight': instance.queriedAtHeight,
    };

DIDKeyRight _$DIDKeyRightFromJson(Map<String, dynamic> json) {
  return DIDKeyRight(
    json['keyLink'] as String,
    (json['history'] as List)
        ?.map((e) => e == null
            ? null
            : DIDKeyRightHistory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['valid'] as bool,
  );
}

Map<String, dynamic> _$DIDKeyRightToJson(DIDKeyRight instance) =>
    <String, dynamic>{
      'keyLink': instance.keyLink,
      'history': instance.history?.map((e) => e?.toJson())?.toList(),
      'valid': instance.valid,
    };

DIDKeyRightHistory _$DIDKeyRightHistoryFromJson(Map<String, dynamic> json) {
  return DIDKeyRightHistory(
    json['height'] as int,
    json['valid'] as bool,
  );
}

Map<String, dynamic> _$DIDKeyRightHistoryToJson(DIDKeyRightHistory instance) =>
    <String, dynamic>{
      'height': instance.height,
      'valid': instance.valid,
    };
