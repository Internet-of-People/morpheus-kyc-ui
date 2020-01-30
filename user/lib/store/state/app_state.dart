import 'package:flutter/widgets.dart';

@immutable
class AppState {
  final bool loading;
  final String activeDid;

  AppState({
    @required this.loading,
    @required this.activeDid,
  });

  @override
  int get hashCode =>
      loading.hashCode ^ activeDid.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            loading == other.loading &&
            activeDid == other.activeDid;
  }
}
