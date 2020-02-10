class RequestsState {
  final List<SentRequest> requests;

  RequestsState(this.requests);

  RequestsState copy() => RequestsState(List.from(requests));

  void add(SentRequest request) => requests.add(request);
}

class SentRequest {
  final String processName;
  final DateTime sentAt;
  final String authority;
  final String capabilityLink;

  SentRequest(this.processName, this.sentAt, this.authority, this.capabilityLink);
}