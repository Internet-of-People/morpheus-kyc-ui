// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did.dart';

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
      (k, e) => MapEntry(_$enumDecodeNullable(_$DIDKeyRightEnumMap, k),
          (e as List)?.map((e) => e as int)?.toList()),
    ),
    json['atHeight'] as int,
    json['tombstoned'] as bool,
  );
}

Map<String, dynamic> _$DIDDocumentToJson(DIDDocument instance) =>
    <String, dynamic>{
      'did': instance.did,
      'keys': instance.keys,
      'rights':
          instance.rights?.map((k, e) => MapEntry(_$DIDKeyRightEnumMap[k], e)),
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

const _$DIDKeyRightEnumMap = {
  DIDKeyRight.impersonate: 'impersonate',
  DIDKeyRight.update: 'update',
};

DIDKey _$DIDKeyFromJson(Map<String, dynamic> json) {
  return DIDKey(
    json['auth'] as String,
    json['validFromHeight'] as int,
    json['validUntilHeight'] as int,
    json['revoked'] as bool,
  );
}

Map<String, dynamic> _$DIDKeyToJson(DIDKey instance) => <String, dynamic>{
      'auth': instance.auth,
      'validFromHeight': instance.validFromHeight,
      'validUntilHeight': instance.validUntilHeight,
      'revoked': instance.revoked,
    };
