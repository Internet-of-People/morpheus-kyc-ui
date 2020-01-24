import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/utils/schema_form/date_selector.dart';
import 'package:morpheus_kyc_user/utils/schema_form/json_form_field.dart';
import 'package:morpheus_kyc_user/utils/schema_form/json_schema_ext.dart';

class SchemaDefinedFormContent extends StatefulWidget {
  final JsonSchema _schema;
  final String _schemaTitle;
  final JsonSchemaFormTree _schemaTree;

  SchemaDefinedFormContent(this._schema, this._schemaTitle, this._schemaTree, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SchemaDefinedFormContentState();
  }
}

class SchemaDefinedFormContentState extends State<SchemaDefinedFormContent> {
  @override
  Widget build(BuildContext context) {
    return _buildObject(widget._schemaTitle, widget._schema, true, widget._schemaTree);
  }

  _buildWidgetFormSchema(String name, JsonSchema schema, bool topLevel, JsonSchemaFormTree schemaTree){
    if(schema.isString()){
      final field = _buildText(name, schema);
      schemaTree[name] = field.valueProvider;
      return _buildContainer(field.widget, topLevel);
    }
    else if(schema.isDate()) {
      final field = _buildDate(name, schema);
      schemaTree[name] = field.valueProvider;
      return _buildContainer(field.widget, topLevel);
    }
    else if(schema.isObject()) {
      JsonSchemaFormTree subTree = JsonSchemaFormTree();
      schemaTree[name] = subTree;
      return _buildContainer(_buildObject(name, schema, false, subTree), topLevel);
    }
    else {
      throw Exception('Not supported JsonSchema type: ${schema.type}');
    }
  }

  Widget _buildObject(String name, JsonSchema schema, bool topLevel, JsonSchemaFormTree schemaTree){
    final style = topLevel ? Theme.of(context).textTheme.headline : Theme.of(context).textTheme.title;
    List<Widget> objectChildren = [
      Row(
        children: <Widget>[Text(toBeginningOfSentenceCase(name), style: style)],
      )
    ];

    for (final entry in schema.properties.entries) {
      objectChildren.add(_buildWidgetFormSchema(
          entry.key,
          entry.value,
          topLevel,
          schemaTree,
      ));
    }

    return Column(children: objectChildren);
  }

  JsonSchemaFormField<String> _buildText(String name, JsonSchema schema){
    final textField = TextFormField(
      decoration: InputDecoration(
          hintText: schema.description,
          labelText: toBeginningOfSentenceCase(name)
      ),
      controller: TextEditingController(),
      validator: schema.getValidators().orElse((_) => null),
    );

    return JsonSchemaFormField.textField(textField, name);
  }

  JsonSchemaFormField<String> _buildDate(String name, JsonSchema schema) {
    final dateSelectorField = DateSelector(
        toBeginningOfSentenceCase(name),
        schema.getValidators().orElse((_) => null),
        TextEditingController(),
    );

    return JsonSchemaFormField.dateSelector(dateSelectorField, name);
  }

  Widget _buildContainer(Widget child, bool topLevel) {
    if(topLevel) {
      return Card(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: child,
        ),
      );
    }
    return child;
  }
}

class JsonSchemaFormTree {
  final Map<String, dynamic> _root = Map();

  operator []=(String key, dynamic value) => _root[key] = value;

  Map<String, dynamic> asMapWithValues() {
    return _parseTree(this);
  }

  Map<String, dynamic> _parseTree(JsonSchemaFormTree tree) {
    Map<String, dynamic> parsed = Map();

    for(final entry in tree._root.entries) {
      if(entry.value is JsonSchemaFormTree) {
        parsed[entry.key] = _parseTree(entry.value as JsonSchemaFormTree);
      }
      else {
        parsed[entry.key] = (entry.value as ValueProvider)();
      }
    }

    return parsed;
  }
}