import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/io/json_schema_ext.dart';
import 'package:morpheus_kyc_user/pages/create_claim_data/date_selector.dart';

class SchemaDefinedForm extends StatefulWidget {
  final JsonSchema _schema;
  final String _schemaTitle;
  final _formKey = GlobalKey<FormState>();

  SchemaDefinedForm(this._schema, this._schemaTitle, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SchemaDefinedFormState();
  }
}

class SchemaDefinedFormState extends State<SchemaDefinedForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: _buildObject(widget._schemaTitle, widget._schema, true),
    );
  }

  _buildWidgetFormSchema(String name, JsonSchema schema, bool topLevel){
    if(schema.isString()){
      return _buildContainer(_buildText(name, schema), topLevel);
    }
    else if(schema.isDate()) {
      return _buildContainer(_buildDate(name, schema), topLevel);
    }
    else if(schema.isObject()) {
      return _buildContainer(_buildObject(name, schema, false), topLevel);
    }
    else {
      throw Exception('Not supported JsonSchema type: ${schema.type}');
    }
  }

  Widget _buildObject(String name, JsonSchema schema, bool topLevel){
    final style = topLevel ? Theme.of(context).textTheme.headline : Theme.of(context).textTheme.title;
    List<Widget> objectChildren = [
      Row(
        children: <Widget>[Text(toBeginningOfSentenceCase(name), style: style)],
      )
    ];

    for (final entry in schema.properties.entries) {
      objectChildren.add(_buildWidgetFormSchema(entry.key, entry.value, topLevel));
    }

    return Column(children: objectChildren);
  }

  Widget _buildText(String name, JsonSchema schema){
    return TextFormField(
      decoration: InputDecoration(
          hintText: schema.description,
          labelText: toBeginningOfSentenceCase(name)
      ),
      // onEditingComplete: ()=>_formKey.currentState.validate(),
      //                          onChanged: (_) => _formKey.currentState.validate(),
      //                          validator: MultiValidator([
      //                            RequiredValidator(errorText: 'Required'),
      //                            MinLengthValidator(2, errorText: 'Min length is 2'),
      //                            MaxLengthValidator(50, errorText: 'Max length is 50')
      //                          ]),
    );
  }

  Widget _buildDate(String name, JsonSchema schema) {
    return DateSelector(toBeginningOfSentenceCase(name));
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