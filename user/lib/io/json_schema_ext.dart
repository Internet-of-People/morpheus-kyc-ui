import 'package:json_schema/json_schema.dart';

const _subTypeKey = 'subtype';

abstract class _SubTypes {
  static final String date = 'date';
}

extension JsonSchemaExt on JsonSchema {
  bool isString() {
    return this.type == SchemaType.string && !this.schemaMap.containsKey(_subTypeKey);
  }

  bool isDate() {
    return this.type == SchemaType.string &&
        this.schemaMap.containsKey(_subTypeKey) &&
        this.schemaMap[_subTypeKey] == _SubTypes.date;
  }

  bool isObject() {
    return this.type == SchemaType.object;
  }
}