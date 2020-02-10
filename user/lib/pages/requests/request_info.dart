import 'package:morpheus_common/io/api/authority/requests.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';

class RequestInfo {
  final RequestStatusResponse status;
  final SentRequest request;

  RequestInfo(this.status, this.request);
}