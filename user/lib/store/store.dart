import 'package:morpheus_kyc_user/store/reducers/app_state_reducer.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:redux/redux.dart';

class AppStore {
  static Store<AppState> _instance;

  AppStore._();

  static Store<AppState> get instance {
    if(_instance == null) {
      _instance = Store<AppState>(
        appReducer,
        initialState: AppState(
            loading: true,
            activeDid: null,
            requests: RequestsState([])
        ),
      );
    }
    return _instance;
  }
}