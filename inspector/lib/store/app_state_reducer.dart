import 'package:morpheus_common/utils/log.dart';
import 'package:redux/redux.dart';

import 'package:morpheus_inspector/store/actions.dart';
import 'package:morpheus_inspector/store/app_state.dart';

AppState scanUrlReducer(AppState state, ScanUrlAction action) {
  return AppState(
    url: action.url,
    presentationJson: state.presentationJson,
    presentation: state.presentation,
    errors: state.errors,
    warnings: state.warnings,
    discount: state.discount,
  );
}

AppState urlDownloadedReducer(AppState state, UrlDownloadedAction action) {
  assert(state.url != null);
  return AppState(
    url: state.url,
    presentationJson: action.presentationJson,
    presentation: state.presentation,
    errors: state.errors,
    warnings: state.warnings,
    discount: state.discount,
  );
}

AppState urlDownloadErrorReducer(AppState state, UrlDownloadErrorAction action) {
  assert(state.url != null);
  return AppState(
    url: state.url,
    presentationJson: null,
    presentation: null,
    errors: [action.error],
    warnings: [],
    discount: state.discount,
  );
}

AppState validatedReducer(AppState state, Validated action) {
  assert(state.url != null);
  //assert(state.presentationJson != null);
  return AppState(
    url: state.url,
    presentationJson: state.presentationJson,
    presentation: action.presentation,
    errors: action.errors,
    warnings: action.warnings,
    discount: state.discount,
  );
}

AppState discountCalculatedReducer(AppState state, DiscountCalculated action) {
  assert(state.url != null);
  assert(state.presentationJson != null);
  assert(state.errors != null);
  assert(state.warnings != null);
  return AppState(
      url: state.url,
      presentationJson: state.presentationJson,
      presentation: state.presentation,
      errors: state.errors,
      warnings: state.warnings,
      discount: action.discount,
  );
}

AppState restartedReducer(AppState state, Restarted action) {
  return AppState.initialState();
}


var _reducer = combineReducers<AppState>([
  TypedReducer(scanUrlReducer),
  TypedReducer(urlDownloadedReducer),
  TypedReducer(urlDownloadErrorReducer),
  TypedReducer(validatedReducer),
  TypedReducer(discountCalculatedReducer),
  TypedReducer(restartedReducer),
]);

AppState appReducer(AppState state, action, Log log) {
  log.debug('Action "$action" reduced');
  return _reducer(state, action);
}