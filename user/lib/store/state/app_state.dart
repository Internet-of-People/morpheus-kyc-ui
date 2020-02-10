import 'package:flutter/widgets.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';

@immutable
class AppState {
  final bool loading;
  final String activeDid;
  final RequestsState requests;

  AppState({
    @required this.loading,
    @required this.activeDid,
    @required this.requests,
  });

  @override
  int get hashCode =>
      loading.hashCode ^ activeDid.hashCode ^ requests.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            loading == other.loading &&
            activeDid == other.activeDid &&
            requests == other.requests;
  }
}
