import 'package:redux/redux.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';

import '../actions.dart';

final authorityApiReducer = combineReducers<AuthorityApi>([
  TypedReducer<AuthorityApi, SetAuthorityApiUrlAction>(_setAuthorityApi)
]);

AuthorityApi _setAuthorityApi(AuthorityApi api, SetAuthorityApiUrlAction action) {
  final newApi = AuthorityApi();
  newApi.apiUrl = action.url;
  return newApi;
}