import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/utils/schema_form/date_selector.dart';

typedef ValueProvider<T> = T Function();

class JsonSchemaFormField<T> {
  final Widget _widget;
  final ValueProvider<T> _valueProvider;

  JsonSchemaFormField(this._widget, this._valueProvider);

  static textField(TextFormField widget, String name) {
    if(widget.controller == null) {
      throw Exception('To be able to use $JsonSchemaFormField, \'$name\' has to have a controller');
    }

    return JsonSchemaFormField(widget, () => widget.controller.text);
  }

  static dateSelector(DateSelector widget, String name) {
    if(widget.controller == null) {
      throw Exception('To be able to use $JsonSchemaFormField, \'$name\' has to have a controller');
    }

    return JsonSchemaFormField(widget, () => widget.controller.text);
  }

  Widget get widget => _widget;

  ValueProvider<T> get valueProvider => _valueProvider;
}

