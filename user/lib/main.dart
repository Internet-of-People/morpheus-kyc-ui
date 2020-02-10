import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/demo/vault.dart';
import 'package:morpheus_common/io/api/native_sdk.dart';
import 'package:morpheus_common/state/actions.dart';
import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/store/reducers/app_state_reducer.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

void main() => runApp(UserApp(
    Store<AppState>(
      appReducer,
      initialState: AppState(
        loading: true,
        activeDid: null,
        requests: RequestsState([])
      ),
    ),
));

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
