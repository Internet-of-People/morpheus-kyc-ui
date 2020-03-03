import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/io/api/sdk/native_sdk.dart';
import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_inspector/pages/main.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:morpheus_inspector/store/store.dart';
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
  final Log _log = Log(InspectorApp);

  @override
  void initState() {
    _log.debug('Initializing app state...');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget._store,
      child: MaterialApp(
        title: 'Inspector App',
        theme: MorpheusTheme.theme,
        home: MainPage(),
      ),
    );
  }

  @override
  void dispose() {
    NativeSDK.instance.dispose();
    super.dispose();
  }
}
