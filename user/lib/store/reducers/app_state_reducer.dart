import 'package:morpheus_kyc_user/store/reducers/sdk_reducer.dart';
import 'package:morpheus_kyc_user/store/reducers/witness_request_reducer.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';

AppState appReducer(AppState state, action){
  return AppState(
    witnessRequest: witnessRequestReducer(state.witnessRequest, action),
    loading: loadingReducer(state.loading, action)
  );
}