import 'package:flutter/widgets.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';

@immutable
class AppState {
  final AuthorityApi authorityApi;
  final List<String> dids;

  AppState({
    this.authorityApi,
    this.dids,
  });

  @override
  int get hashCode => authorityApi.hashCode ^ dids.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            authorityApi == other.authorityApi &&
            dids == other.dids;
  }
}