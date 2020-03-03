import 'dart:io';

import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_inspector/store/reducers/app_state_reducer.dart';
import 'package:morpheus_inspector/store/state/app_state.dart';
import 'package:morpheus_inspector/store/state/requests_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';

class AppStore {
  static Store<AppState> _instance;
  static Log _log = Log(AppStore);

  AppStore._();

  static Future<Store<AppState>> getInstance() async {
    if(_instance == null) {
      _log.debug('Creating store');
      final storageDir = await getApplicationDocumentsDirectory();
      final path = '${storageDir.path}/.config/state.json';
      _log.debug('Storage will be at $path');

      _log.debug('Creating persistor');
      final persistor = Persistor<AppState>(
        storage: FileStorage(File(path)),
        serializer: JsonSerializer<AppState>(AppState.fromJson),
      );

      _log.debug('Loading persisted state');
      final persistedState = await persistor.load();
      _log.debug('Creating instance');

      _instance = Store<AppState>(
        appReducer,
        initialState: persistedState != null
          ? persistedState
          : AppState.initialState(),
        middleware: [persistor.createMiddleware()],
      );
      _log.debug('Store is ready');
    }
    return _instance;
  }
}