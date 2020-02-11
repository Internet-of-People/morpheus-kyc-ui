import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/demo/vault.dart';
import 'package:morpheus_common/io/api/sdk/native_sdk.dart';
import 'package:morpheus_common/state/actions.dart';
import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_common/utils/log.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:witness/pages/home.dart';
import 'package:witness/store/reducers/app_state_reducer.dart';
import 'package:witness/store/state/app_state.dart';

void main() {
  runApp(WitnessApp(
    Store<AppState>(
      appReducer,
      initialState: AppState(
          loading: true,
          activeDid: null
      ),
    ),
  ));
}

class WitnessApp extends StatefulWidget {
  final Store<AppState> _store;

  const WitnessApp(this._store, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WitnessAppState();
  }
}

class WitnessAppState extends State<WitnessApp> {
  Future<Directory> _applicationsDocDirFut;
  final Log _log = Log(WitnessAppState);

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
          if(snapshot.hasData && widget._store.state.loading) {
            _log.debug('Using directory for storage: ${snapshot.data}');
            VaultLoader.load(
                snapshot.data,
                    (did) => widget._store.dispatch(SetActiveDIDAction(did)),
                    () => widget._store.dispatch(SetAppLoadingAction(false))
            );
          }

          return StoreProvider<AppState>(
            store: widget._store,
            child: MaterialApp(
              title: 'Witness',
              theme: MorpheusTheme.theme,
              home: snapshot.hasData ? HomePage() : CircularProgressIndicator(),
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    NativeSDK.instance.dispose();
    super.dispose();
  }
}