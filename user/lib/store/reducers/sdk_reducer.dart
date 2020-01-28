import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/store/state.dart';
import 'package:redux/redux.dart';

final sdkReducer = combineReducers<SDKState>([
  TypedReducer<SDKState, SetSDKLoadingAction>(_setLoading)
]);

SDKState _setLoading(SDKState oldState, SetSDKLoadingAction action) {
  final newState = SDKState(sdk: oldState.sdk, loading: action.loading);
  return newState;
}