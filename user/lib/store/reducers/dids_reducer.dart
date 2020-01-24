import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:redux/redux.dart';

final didsReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, SetDidsAction>(_setDids)
]);

List<String> _setDids(_, SetDidsAction action) {
  return action.dids;
}