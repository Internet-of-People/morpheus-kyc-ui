import 'package:flutter/widgets.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority_api.dart';
import 'package:morpheus_kyc_user/io/api/authority/witness_request.dart';

@immutable
class AppState {
  final AuthorityApi authorityApi;
  final List<String> dids;
  final WitnessRequest witnessRequest;

  AppState({
    @required this.authorityApi,
    @required this.dids,
    @required this.witnessRequest,
  });

  @override
  int get hashCode => authorityApi.hashCode ^ dids.hashCode ^ witnessRequest.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            authorityApi == other.authorityApi &&
            dids == other.dids &&
            witnessRequest == other.witnessRequest;
  }
}