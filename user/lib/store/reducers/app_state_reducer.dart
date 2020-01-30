import 'package:morpheus_kyc_user/store/reducers/active_did_reducer.dart';
import 'package:morpheus_kyc_user/store/reducers/loading_reducer.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';

AppState appReducer(AppState state, action){
  return AppState(
    loading: loadingReducer(state.loading, action),
    activeDid: activeDidReducer(state.activeDid, action),
  );
}