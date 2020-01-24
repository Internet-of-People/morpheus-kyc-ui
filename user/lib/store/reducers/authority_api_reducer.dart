import 'package:morpheus_kyc_user/io/api/authority/authority_api.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:redux/redux.dart';


final authorityApiReducer = combineReducers<AuthorityApi>([
  TypedReducer<AuthorityApi, SetAuthorityApiUrlAction>(_setAuthorityApi)
]);

AuthorityApi _setAuthorityApi(AuthorityApi api, SetAuthorityApiUrlAction action) {
  final newApi = AuthorityApi();
  newApi.apiUrl = action.url;
  return newApi;
}