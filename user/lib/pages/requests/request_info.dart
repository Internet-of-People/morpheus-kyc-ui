import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:morpheus_sdk/authority.dart';

class RequestInfo {
  final RequestStatusResponse status;
  final SentRequest request;

  RequestInfo(this.status, this.request);
}