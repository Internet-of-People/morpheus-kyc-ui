import 'package:flutter/widgets.dart';

@immutable
class AppState {
  final String activeDid;

  AppState({
    @required this.activeDid,
  });

  @override
  int get hashCode =>
      activeDid.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            activeDid == other.activeDid;
  }
}
