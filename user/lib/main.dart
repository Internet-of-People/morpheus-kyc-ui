import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/demo/vault.dart';
import 'package:morpheus_common/state/actions.dart';
import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_kyc_user/app_model.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/store.dart';
import 'package:morpheus_sdk/crypto.dart';
import 'package:morpheus_sdk/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

void main() {
  final log = Log(UserApp);
  WidgetsFlutterBinding.ensureInitialized();
  () async {
    log.debug(('Bootstrapping application...'));
    final store = await AppStore.getInstance();
    log.debug('Store created, running app...');
    runApp(UserApp(store));
  }();
}

class UserApp extends StatefulWidget {
  final Store<AppState> _store;

  const UserApp(this._store, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserAppState();
  }
}

class UserAppState extends State<UserApp> {
  Future<Directory> _applicationsDocDirFut;
  final Log _log = Log(UserApp);
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
        }
      ),
    );
  }

  @override
  void dispose(){
    CryptoAPI.disposeIfCreated();
    super.dispose();
  }
}
