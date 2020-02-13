import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/io/api/core/requests.dart';

part 'requests.g.dart';

@JsonSerializable(explicitToJson: true)
class WitnessRequestsResponse {
  final List<WitnessRequestStatus> requests;

  WitnessRequestsResponse(this.requests);

  factory WitnessRequestsResponse.fromJson(Map<String, dynamic> json) => _$WitnessRequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RequestStatusResponse {
  final RequestStatus status;
  final SignedWitnessStatement signedStatement;
  final String rejectionReason;

  RequestStatusResponse(this.status, this.signedStatement, this.rejectionReason);

  factory RequestStatusResponse.fromJson(Map<String, dynamic> json) => _$RequestStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStatusResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WitnessRequestStatus {
  final String capabilityLink;
  final String requestId;
  final DateTime dateOfRequest;
  final RequestStatus status;
  final String processId;
  final String notes;

  WitnessRequestStatus(this.capabilityLink, this.requestId, this.dateOfRequest, this.status, this.processId, this.notes);

  factory WitnessRequestStatus.fromJson(Map<String, dynamic> json) => _$WitnessRequestStatusFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessRequestStatusToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendWitnessRequestResponse {
  final String capabilityLink;

  SendWitnessRequestResponse(this.capabilityLink);

  factory SendWitnessRequestResponse.fromJson(Map<String, dynamic> json) => _$SendWitnessRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendWitnessRequestResponseToJson(this);
}