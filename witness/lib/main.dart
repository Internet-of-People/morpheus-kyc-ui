import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/demo/vault.dart';
import 'package:morpheus_common/state/actions.dart';
import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_sdk/crypto.dart';
import 'package:morpheus_sdk/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:witness/app_model.dart';
import 'package:witness/pages/home.dart';
import 'package:witness/store/reducers/app_state_reducer.dart';
import 'package:witness/store/state/app_state.dart';

void main() {
  runApp(WitnessApp(
    Store<AppState>(
      appReducer,
      initialState: AppState(
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
  bool _loading = true;

  @override
  void initState() {
    _log.debug('Initializing app state...');
    super.initState();
    _applicationsDocDirFut = getApplicationDocumentsDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppModel>(create: (_) => AppModel(CryptoAPI.create('libmorpheus_sdk.so')))
      ],
      child: FutureBuilder(
        future: _applicationsDocDirFut,
        builder: (context, AsyncSnapshot<Directory> snapshot) {
          if(snapshot.hasData && _loading) {
            _log.debug('Using directory for storage: ${snapshot.data}');
            VaultLoader.load(
                Provider.of<AppModel>(context, listen: false).cryptoAPI,
                snapshot.data,
                (did) => widget._store.dispatch(SetActiveDIDAction(did)),
                () => _loading = false
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
      ),
    );
  }

  @override
  void dispose() {
    CryptoAPI.disposeIfCreated();
    super.dispose();
  }
}