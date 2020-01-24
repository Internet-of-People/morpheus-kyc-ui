import 'package:morpheus_kyc_user/io/api/authority/witness_request.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:redux/redux.dart';

final witnessRequestReducer = combineReducers<WitnessRequest>([
  TypedReducer<WitnessRequest, SetWitnessRequestClaimDataAction>(_setClaimData)
]);

WitnessRequest _setClaimData(WitnessRequest old, SetWitnessRequestClaimDataAction action) {
  WitnessRequest newWr = WitnessRequest(claimData: action.claimData);
  return newWr;
}