import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, SetAppLoadingAction>(_setLoading)
]);

bool _setLoading(_, SetAppLoadingAction action) {
  return action.loading;
}