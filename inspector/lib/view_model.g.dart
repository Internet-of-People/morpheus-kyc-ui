// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressProof _$DigitalIdCardFromJson(Map<String, dynamic> json) {
  return AddressProof(
    address: json['address'] as String
  );
}

Map<String, dynamic> _$DigitalIdCardToJson(AddressProof instance) =>
    <String, dynamic>{
      'address': instance.address
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
