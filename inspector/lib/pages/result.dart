import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

import 'package:morpheus_inspector/store/app_state.dart';

class _ValidationItem {
  final bool isError;
  final String text;

  _ValidationItem(this.isError, this.text) {
    print('${this.isError} ${this.text}');
  }
}

class _ResultViewModel {
  final AppState _state;
  final Function _dispatch;

  _ResultViewModel(this._state, this._dispatch);

  bool get hasError => _state.errors?.isNotEmpty ?? true;
  bool get hasWarning => _state.warnings?.isNotEmpty ?? true;
  List<_ValidationItem> get items {
    print(_state.presentationJson);
    print(_state.errors);
    print(_state.warnings);
    final errorItems = _state.errors?.map((e) => _ValidationItem(true, e))?.toList() ?? [];
    final warningItems = _state.warnings?.map((w) => _ValidationItem(false, w))?.toList() ?? [];
    return errorItems + warningItems;
  }

  void toHome() {
    _dispatch(NavigateToAction.pop());
  }
}

class ResultPage extends StatelessWidget {
  ResultPage({ Key key }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ResultViewModel>(
        converter: (store) => _ResultViewModel(store.state, store.dispatch),
        builder: (context, vm) => Scaffold(
            appBar: AppBar(
              backgroundColor: _color(context, vm),
              title: Text('Result'),
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(16),
                color: _color(context, vm),
                child: Container(
                  color: Theme.of(context).dialogBackgroundColor,
                  child: ListView(
                    children: vm.items.map(_buildItem).toList(),
                  ),
                ),
              ),
            ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.home),
            onPressed: vm.toHome,
          ),
        )
    );
  }

  Color _color(BuildContext context, _ResultViewModel vm) {
    if (vm.hasError) {
      return Colors.redAccent;
    } else if (vm.hasWarning) {
      return Colors.orangeAccent;
    } else {
      return Colors.lightGreen;
    }
  }

  Widget _buildItem(_ValidationItem e) {
    final leading = e.isError ? Icons.error : Icons.warning;
    return ListTile(
      leading: Icon(leading),
      title: Text(e.text),
    );
  }
}
