import 'package:morpheus_common/state/actions.dart';
import 'package:redux/redux.dart';

final activeDidReducer = combineReducers<String>([
  TypedReducer<String, SetActiveDIDAction>(_setActiveDID)
]);

String _setActiveDID(_, SetActiveDIDAction action) {
  return action.did;
}