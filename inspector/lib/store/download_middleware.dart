import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:morpheus_inspector/store/routes.dart';
import 'package:redux/redux.dart';

import 'package:morpheus_common/sdk/http_tools.dart';
import 'package:morpheus_inspector/store/actions.dart';

class DownloadMiddleware implements MiddlewareClass {
  @override
  call(Store store, action, next) async {
    if (action is ScanUrlAction) {
      try {
        final presentation = await HttpTools.httpGet(action.url);
        store.dispatch(UrlDownloadedAction(presentation));
      } on Exception catch (e) {
        store.dispatch(UrlDownloadErrorAction(e.toString()));
        store.dispatch(NavigateToAction.replace(Routes.result));
      }
    }
    next(action);
  }
}
