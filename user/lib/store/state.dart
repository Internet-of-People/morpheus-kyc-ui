import 'package:flutter/widgets.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority_api.dart';
import 'package:morpheus_kyc_user/io/api/authority/witness_request.dart';
import 'package:morpheus_dart/rust.dart' show RustSdk;

@immutable
class AppState {
  final AuthorityApi authorityApi;
  final List<String> dids;
  final WitnessRequest witnessRequest;
  final SDKState native;

  AppState({
    @required this.authorityApi,
    @required this.dids,
    @required this.witnessRequest,
    @required this.native,
  });

  @override
  int get hashCode =>
      authorityApi.hashCode ^
      dids.hashCode ^
      witnessRequest.hashCode ^
      native.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            authorityApi == other.authorityApi &&
            dids == other.dids &&
            witnessRequest == other.witnessRequest &&
            native == other.native;
  }
}

class SDKState {
  final RustSdk sdk;
  final bool loading;

  SDKState({
    @required this.sdk,
    @required this.loading
  });

  @override
  int get hashCode =>
      sdk.hashCode ^
      loading.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is SDKState &&
            sdk == other.sdk &&
            loading == other.loading;
  }
}