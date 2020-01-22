import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/store/reducers/app_state_reducer.dart';
import 'package:morpheus_kyc_user/store/state.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

void main() => runApp(KYCApp(
    store: Store<AppState>(
      appReducer,
      initialState: AppState(
        dids: null,
        authorityApi: AuthorityApi()
      ),
    ),
));

class KYCApp extends StatelessWidget {
  final Store<AppState> store;

  const KYCApp({Key key, @required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Morpheus KYC PoC',
        theme: ThemeData(
          primarySwatch: primaryMaterialColor,
        ),
        home: HomePage(),
      ),
    );
  }
}
