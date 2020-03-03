import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/demo/vault.dart';
import 'package:morpheus_common/io/api/sdk/native_sdk.dart';
import 'package:morpheus_common/state/actions.dart';
import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_inspector/pages/home/home.dart';
import 'package:morpheus_inspector/store/state/app_state.dart';
import 'package:morpheus_inspector/store/store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

void main() {
  Log log = Log(InspectorApp);
  WidgetsFlutterBinding.ensureInitialized();
  () async {
    log.debug(('Bootstrapping application...'));
    final store = await AppStore.getInstance();
    log.debug('Store created, running app...');
    runApp(InspectorApp(store));
  }();
}

class InspectorApp extends StatefulWidget {
  final Store<AppState> _store;

  const InspectorApp(this._store, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InspectorAppState();
  }
}

class InspectorAppState extends State<InspectorApp> {
  Future<Directory> _applicationsDocDirFut;
  final Log _log = Log(InspectorApp);
  bool _loading = true;

  @override
  void initState() {
    _log.debug('Initializing app state...');
    super.initState();
    _applicationsDocDirFut = getApplicationDocumentsDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _applicationsDocDirFut,
      builder: (context, AsyncSnapshot<Directory> snapshot) {
        if(snapshot.hasData && _loading) {
          _log.debug('Using directory for storage: ${snapshot.data}');
          VaultLoader.load(
            snapshot.data,
              (did) => widget._store.dispatch(SetActiveDIDAction(did)),
              () => _loading = false,
          );
        }

        return StoreProvider<AppState>(
          store: widget._store,
          child: MaterialApp(
            title: 'User App',
            theme: MorpheusTheme.theme,
            home: snapshot.hasData ? HomePage() : CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    NativeSDK.instance.dispose();
    super.dispose();
  }
}
