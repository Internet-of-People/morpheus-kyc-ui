import 'dart:async';
import 'dart:convert';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_inspector/store/routes.dart';
import 'package:redux/redux.dart';

import 'package:morpheus_inspector/store/actions.dart';

class VerifierMiddleware implements MiddlewareClass {
  @override
  call(Store store, action, next) async {
    if (action is UrlDownloadedAction) {
      SignedPresentation presentation;
      List<String> errors = [];
      List<String> warnings = [];
      try {
        presentation = SignedPresentation.fromJson(json.decode(action.presentationJson));
      } catch(e) {
        errors.add(e.toString());
      }
      store.dispatch(NavigateToAction.replace(Routes.result));
      store.dispatch(Validated(presentation, errors, warnings));
    }
    next(action);
  }
}