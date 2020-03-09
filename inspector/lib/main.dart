import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:morpheus_common/sdk/native_sdk.dart';
import 'package:redux/redux.dart';

import 'package:morpheus_common/theme/theme.dart';
import 'package:morpheus_common/utils/log.dart';

import 'pages/home.dart';
import 'pages/scan_qr.dart';
import 'store/app_state.dart';
import 'store/store.dart';
import 'pages/processing.dart';

abstract class Routes {
  static const String scan = '/scan';
  static const String processing = '/processing';
  static const String home = '/home';
}

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
        return _route(settings, (context) => QrScan());
      case Routes.processing:
        return _route(settings, (context) => Processing());
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
