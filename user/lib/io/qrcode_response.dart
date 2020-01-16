import 'package:json_annotation/json_annotation.dart';

part 'qrcode_response.g.dart';

@JsonSerializable()
class QRCodeResponse {
  final String apiUrl;

  QRCodeResponse(this.apiUrl);

  factory QRCodeResponse.fromJson(
      Map<String, dynamic> json
  ) => _$QRCodeResponseFromJson(json);
}