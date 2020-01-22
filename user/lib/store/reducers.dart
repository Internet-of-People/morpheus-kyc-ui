import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/store/state.dart';
import 'package:redux/redux.dart';

final appReducers = combineReducers<AppState>([
  TypedReducer<AppState, SetAPIAction>(_apiUrlReducer)
]);

AppState _apiUrlReducer(AppState state, SetAPIAction action) => AppState(action.apiUrl);
