import 'package:morpheus_common/io/api/authority/requests.dart';
import 'package:morpheus_common/io/api/core/processes.dart';

class RequestCollectedInfo {
  final RequestStatusResponse status;
  final Process process;
  final WitnessRequestStatus request;

  RequestCollectedInfo(this.status, this.process, this.request);
}