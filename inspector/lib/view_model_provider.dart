import 'package:flutter/material.dart';

import 'package:morpheus_inspector/view_model.dart';

class ViewModel extends InheritedWidget {
  final AppViewModel _vm;

  ViewModel({ Key key, Widget child }):
        _vm = AppViewModel(),
        super(key: key, child: child);

  AppViewModel get vm => _vm;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is ViewModel) {
      return oldWidget.vm != vm;
    }
    return false;
  }

  static AppViewModel of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ViewModel>().vm;
  }
}
