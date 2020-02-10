import 'package:morpheus_kyc_user/store/actions/actions.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:redux/redux.dart';

final requestsReducer = combineReducers<RequestsState>([
  TypedReducer<RequestsState, AddRequestAction>(_addRequest)
]);

RequestsState _addRequest(RequestsState oldState, AddRequestAction action) {
  return oldState.copy()..add(action.request);
}