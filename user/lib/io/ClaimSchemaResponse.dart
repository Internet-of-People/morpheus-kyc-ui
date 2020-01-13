import 'package:json_annotation/json_annotation.dart';

//part 'ClaimSchemaResponse.g.dart';

@JsonSerializable()
class ClaimSchemaResponse {
  String type;

  //factory ClaimSchemaResponse.fromJson(Map<String, dynamic> json) => _$ProcessResponseFromJson(json);
}

@JsonSerializable()
class PlaceOfBirth {
  final String country;
  final String city;

  PlaceOfBirth(this.country, this.city);
}

/*
{
  "type": "object",
  "required": ["address","placeOfBirth","dateOfBirth"],
  "description": "This claim contains the subject's address, place of birth and date of birth visible on their ID card.",
  "properties": {
    "address": {
      "type": "string",
      "maskable": true
    },
    "placeOfBirth": {
      "type": "object",
      "required":["country","city"],
      "maskable": true,
      "properties": {
        "country": {
          "type": "string",
          "name": "Country",
          "maskable": true
        },
        "city": {
          "type": "string",
          "maskable": true,
          "minLength": 2,
          "maxLength": 50
        }
      }
    },
    "dateOfBirth": {
      "type": "string",
      "pattern": "^(0[1-9]|1[0-9]|2[0-9]|3[0-1])\\\/(0[1-9]|1[0-2])\\\/(\\d{4})$",
      "maskable": true,
      "minLength": 12,
      "maxLength": 12
    }
  }
}
* */