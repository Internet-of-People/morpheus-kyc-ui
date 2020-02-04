import 'package:morpheus_common/state/reducers/active_did_reducer.dart';
import 'package:morpheus_common/state/reducers/loading_reducer.dart';
import 'package:witness/store/state/app_state.dart';

AppState appReducer(AppState state, action){
  return AppState(
    loading: loadingReducer(state.loading, action),
    activeDid: activeDidReducer(state.activeDid, action),
  );
}