import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_inspector/store/app_state_reducer.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:morpheus_inspector/store/download_middleware.dart';
import 'package:morpheus_inspector/store/verifier_middleware.dart';

class AppStore {
  static Store<AppState> _instance;
  static Log _log = Log(AppStore);

  AppStore._();

  static Future<Store<AppState>> getInstance() async {
    if(_instance == null) {
      _log.debug('Creating store');

      _log.debug('Creating persistor');
      final persistor = Persistor<AppState>(
        storage: FlutterStorage(),
        serializer: JsonSerializer<AppState>(AppState.fromJson),
      );

      _log.debug('Loading persisted state');
      final persistedState = await persistor.load();
      _log.debug('Creating instance');

      _instance = Store<AppState>(
        (state, action) => appReducer(state, action, _log),
        initialState: persistedState != null
          ? persistedState
          : AppState.initialState(),
        middleware: [
          _logAction,
          persistor.createMiddleware(),
          NavigationMiddleware(),
          DownloadMiddleware(),
          VerifierMiddleware(),
        ],
      );
      _log.debug('Store is ready');
    }
    return _instance;
  }

  static _logAction(Store<AppState> state, action, next) {
    _log.debug('Action "$action" fired');
    next(action);
  }

}