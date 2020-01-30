import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_kyc_user/io/api/authority/witness_request.dart';
import 'package:morpheus_kyc_user/io/api/native_sdk.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/store/reducers/app_state_reducer.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/utils/log.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

void main() => runApp(KYCApp(
    Store<AppState>(
      appReducer,
      initialState: AppState(
        loading: true,
        witnessRequest: WitnessRequest(),
      ),
    ),
));

class KYCApp extends StatefulWidget {
  final Store<AppState> _store;

  const KYCApp(this._store, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return KYCAppState();
  }
}

class KYCAppState extends State<KYCApp> {
  Future<Directory> _applicationsDocDirFut;
  final Log _log = Log(KYCApp);

  @override
  void initState() {
    super.initState();
    _applicationsDocDirFut = getApplicationDocumentsDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _applicationsDocDirFut,
      builder: (context, AsyncSnapshot<Directory> snapshot) {
        if(snapshot.hasData && widget._store.state.loading) {
          _loadVault(snapshot.data);
        }

        return StoreProvider<AppState>(
          store: widget._store,
          child: MaterialApp(
            title: 'Morpheus KYC PoC',
            theme: ThemeData(
              primarySwatch: primaryMaterialColor,
            ),
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

  void _loadVault(Directory appDocDir) {
    try {
      _log.debug('Loading vault...');
      final vaultPath =
          '${appDocDir.path}/.config/prometheus/did_vault.dat';
      try {
        NativeSDK.instance.loadVault(vaultPath);
        _log.debug('Vault loaded from $vaultPath');
      } catch (e) {
        // TODO: FOR DEMO PURPOSES
        NativeSDK.instance.createVault(
            'include pear escape sail spy orange cute despair witness trouble sleep torch wire burst unable brass expose fiction drift clock duck oxygen aerobic already',
            vaultPath
        );
        _log.debug('Vault was not found, created a new one at $vaultPath');
      }

      while (NativeSDK.instance.listDids().length < 2) {
        _log.debug('Creating did: ${NativeSDK.instance.createDid()}...');
        _log.debug('Did created');
      }

      NativeSDK.instance.realLedger('http://35.187.56.222:4703'); // TESTNET
    } catch(e) {
      _log.error('Error using SDK: $e');
    } finally {
      widget._store.dispatch(SetAppLoadingAction(false));
    }
  }
}
