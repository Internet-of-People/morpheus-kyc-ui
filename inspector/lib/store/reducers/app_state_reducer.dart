import 'package:morpheus_common/state/reducers/active_did_reducer.dart';
import 'package:morpheus_inspector/store/reducers/requests_reducer.dart';
import 'package:morpheus_inspector/store/state/app_state.dart';

AppState appReducer(AppState state, action){
  return AppState(
    activeDid: activeDidReducer(state.activeDid, action),
    requests: requestsReducer(state.requests, action),
  );
}