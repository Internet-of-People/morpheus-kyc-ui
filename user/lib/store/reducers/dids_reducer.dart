import 'package:redux/redux.dart';

import '../actions.dart';

final didsReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, SetDidsAction>(_setDids)
]);

List<String> _setDids(_, SetDidsAction action) {
  return action.dids;
}