import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';

class SetAuthorityApiUrlAction {
  final String url;

  SetAuthorityApiUrlAction(this.url);
}

class SetDidsAction {
  final List<String> dids;

  SetDidsAction(this.dids);
}