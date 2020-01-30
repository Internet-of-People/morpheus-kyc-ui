import 'package:flutter/widgets.dart';
import 'package:morpheus_kyc_user/io/api/authority/witness_request.dart';

@immutable
class AppState {
  final bool loading;
  final WitnessRequest witnessRequest; // TODO it should not be in the global state

  AppState({
    @required this.loading,
    @required this.witnessRequest,
  });

  @override
  int get hashCode =>
      witnessRequest.hashCode ^
      loading.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            witnessRequest == other.witnessRequest &&
            loading == other.loading;
  }
}
