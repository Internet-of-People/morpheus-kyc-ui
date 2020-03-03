import 'package:morpheus_inspector/store/actions.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:redux/redux.dart';

AppState scanUrlReducer(AppState state, ScanUrlAction action) {
  return AppState(url: action.url);
}

AppState urlDownloadedReducer(AppState state, UrlDownloadedAction action) {
  assert(state.url != null);
  return AppState(url: state.url, presentationJson: action.presentationJson);
}

AppState signaturesValidatedReducer(AppState state, SignaturesValidated action) {
  assert(state.url != null);
  assert(state.presentationJson != null);
  return AppState(url: state.url, presentationJson: state.presentationJson, signatureErrors: action.signatureErrors);
}

AppState discountCalculatedReducer(AppState state, DiscountCalculated action) {
  assert(state.url != null);
  assert(state.presentationJson != null);
  assert(state.signatureErrors != null);
  return AppState(url: state.url, presentationJson: state.presentationJson, signatureErrors: state.signatureErrors, discount: action.discount);
}

AppState restartedReducer(AppState state, Restarted action) {
  return AppState();
}

final stateReducer = combineReducers<AppState>([
  TypedReducer(scanUrlReducer),
  TypedReducer(urlDownloadedReducer),
  TypedReducer(signaturesValidatedReducer),
  TypedReducer(discountCalculatedReducer),
  TypedReducer(restartedReducer),
]);

AppState appReducer(AppState state, action) {
  return stateReducer(state, action);
}