import 'package:morpheus_kyc_user/store/reducers/authority_api_reducer.dart';
import 'package:morpheus_kyc_user/store/reducers/dids_reducer.dart';
import 'package:morpheus_kyc_user/store/reducers/sdk_reducer.dart';
import 'package:morpheus_kyc_user/store/reducers/witness_request_reducer.dart';
import 'package:morpheus_kyc_user/store/state.dart';

AppState appReducer(AppState state, action){
  return AppState(
    authorityApi: authorityApiReducer(state.authorityApi, action),
    dids: didsReducer(state.dids, action),
    witnessRequest: witnessRequestReducer(state.witnessRequest, action),
    native: sdkReducer(state.native, action)
  );
}