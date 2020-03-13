// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalIdCard _$DigitalIdCardFromJson(Map<String, dynamic> json) {
  return DigitalIdCard(
    address: json['address'] as String,
    placeOfBirth: json['placeOfBirth'] == null
        ? null
        : PlaceOfBirth.fromJson(json['placeOfBirth'] as Map<String, dynamic>),
    dateOfBirth: json['dateOfBirth'] as String,
  );
}

Map<String, dynamic> _$DigitalIdCardToJson(DigitalIdCard instance) =>
    <String, dynamic>{
      'address': instance.address,
      'placeOfBirth': instance.placeOfBirth?.toJson(),
      'dateOfBirth': instance.dateOfBirth,
    };

PlaceOfBirth _$PlaceOfBirthFromJson(Map<String, dynamic> json) {
  return PlaceOfBirth(
    country: json['country'] as String,
    city: json['city'] as String,
  );
}

Map<String, dynamic> _$PlaceOfBirthToJson(PlaceOfBirth instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
    };
