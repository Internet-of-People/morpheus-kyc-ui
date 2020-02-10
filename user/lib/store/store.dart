import 'package:morpheus_kyc_user/store/reducers/app_state_reducer.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:redux/redux.dart';

Store<AppState> storeInstance () => Store<AppState>(
  appReducer,
  initialState: AppState(
      loading: true,
      activeDid: null,
      requests: RequestsState([])
  ),
);