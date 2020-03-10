import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:morpheus_inspector/pages/result.dart';
import 'package:redux/redux.dart';

import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_common/sdk/native_sdk.dart';
import 'package:morpheus_inspector/pages/home.dart';
import 'package:morpheus_inspector/pages/scan_qr.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:morpheus_inspector/store/routes.dart';
import 'package:morpheus_inspector/store/store.dart';
import 'package:morpheus_inspector/pages/processing.dart';

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
    return _InspectorAppState();
  }
}

class _InspectorAppState extends State<InspectorApp> {
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
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
        initialRoute: Routes.home,
      ),
    );
  }

  @override
  void dispose() {
    _log.debug('Disposing app state...');
    NativeSDK.instance.dispose();
    super.dispose();
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.scan:
        return _route(settings, (context) => QrScanPage());
      case Routes.processing:
        return _route(settings, (context) => ProcessingPage());
      case Routes.result:
        return _route(settings, (context) => ResultPage());
      case Routes.home:
      default:
        return _route(settings, (context) => HomePage());
    }
  }

  Route _route(RouteSettings settings, Widget Function(BuildContext context) builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
    );
  }
}
