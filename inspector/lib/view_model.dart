import 'dart:collection';
import 'dart:convert';

import 'package:morpheus_common/sdk/http_tools.dart';
import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_common/utils/log.dart';

class ValidationItem {
  final bool isError;
  final String text;
  final String detail;

  ValidationItem(this.isError, this.text, this.detail);
}

class ValidationResult {
  final List<ValidationItem> _items;

  ValidationResult(this._items);

  UnmodifiableListView<ValidationItem> get items => UnmodifiableListView(_items);
  bool get hasWarning => _items.isNotEmpty;
  bool get hasError => _items.any((i) => i.isError);
}

class AppViewModel {
  final Log _log = Log(AppViewModel);
  String _url;
  Future<SignedPresentation> presentation;
  Future<ValidationResult> validation;
  Future<int> discount;

  String get url => _url;

  void gotUrl(String url) {
    _log.debug('Got URL $url');
    _url = url;
    presentation = _download();
  }

  Future<SignedPresentation> _download() async {
    try {
      final jsonString = await HttpTools.httpGet(url);
      final result = SignedPresentation.fromJson(json.decode(jsonString));
      validation = _validate();
      return result;
    } catch (e) {
      final errorItem = ValidationItem(true, 'Error while downloading $url', e.toString());
      validation = Future.value(ValidationResult([errorItem]));
      return null;
    }
  }

  Future<ValidationResult> _validate() async {
    final warningItem = ValidationItem(false, 'Validation is not implemented yet', '');
    return ValidationResult([warningItem]);
  }
}
