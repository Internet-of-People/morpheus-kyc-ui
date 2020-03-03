import 'package:json_annotation/json_annotation.dart';

part 'requests_state.g.dart';

@JsonSerializable(explicitToJson: true)
class RequestsState {
  final List<SentRequest> requests;

  RequestsState(this.requests);

  RequestsState copy() => RequestsState(List.from(requests));

  void add(SentRequest request) => requests.add(request);

  factory RequestsState.fromJson(Map<String, dynamic> json) => _$RequestsStateFromJson(json);

  Map<String, dynamic> toJson() => _$RequestsStateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SentRequest {
  final String processName;
  final DateTime sentAt;
  final String authority;
  final String capabilityLink;

  SentRequest(this.processName, this.sentAt, this.authority, this.capabilityLink);

  factory SentRequest.fromJson(Map<String, dynamic> json) => _$SentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SentRequestToJson(this);
}