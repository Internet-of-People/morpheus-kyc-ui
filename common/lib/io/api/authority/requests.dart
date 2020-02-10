import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/io/api/core/requests.dart';

part 'requests.g.dart';

@JsonSerializable(explicitToJson: true)
class WitnessRequestsResponse {
  final List<WitnessRequestWithMetaData> requests;

  WitnessRequestsResponse(this.requests);

  factory WitnessRequestsResponse.fromJson(Map<String, dynamic> json) => _$WitnessRequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RequestStatusResponse {
  final RequestStatus status;
  final SignedStatement signedStatement;
  final String rejectionReason;

  RequestStatusResponse(this.status, this.signedStatement, this.rejectionReason);

  factory RequestStatusResponse.fromJson(Map<String, dynamic> json) => _$RequestStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStatusResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WitnessRequestWithMetaData {
  final String hashlink;
  final WitnessRequestMetaData metadata;

  WitnessRequestWithMetaData(this.hashlink, this.metadata);

  factory WitnessRequestWithMetaData.fromJson(Map<String, dynamic> json) => _$WitnessRequestWithMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestWithMetaDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WitnessRequestMetaData {
  final int dateOfRequest;
  final RequestStatus status;
  final String process;

  WitnessRequestMetaData(this.dateOfRequest, this.status, this.process);

  factory WitnessRequestMetaData.fromJson(Map<String, dynamic> json) => _$WitnessRequestMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestMetaDataToJson(this);
}
