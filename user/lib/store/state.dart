import 'package:flutter/widgets.dart';

@immutable
class AppState {
  final String apiUrl;

  AppState(this.apiUrl);

  @override
  int get hashCode => apiUrl.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState && apiUrl == other.apiUrl;
  }
}