import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';

class RequestInfo {
  final RequestStatusResponse status;
  final SentRequest request;

  RequestInfo(this.status, this.request);
}