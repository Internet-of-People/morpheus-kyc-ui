import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_common/utils/schema_form/form_field_validators_extra.dart';
import 'package:morpheus_sdk/utils.dart';
import 'package:optional/optional.dart';

const _subTypeKey = 'subtype';

abstract class _SubTypes {
  static final String date = 'date';
  static final String photo = 'photo';
  static final String email = 'email';
  static final String nonce = 'nonce';
  static final String contentId = 'contentId';
}

final _log = Log(JsonSchema);

extension JsonSchemaExt on JsonSchema {
  bool isString() {
    return type == SchemaType.string && !schemaMap.containsKey(_subTypeKey);
  }

  bool isNumber() {
    return type == SchemaType.number;
  }

  bool isContentId() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.contentId;
  }

  bool isDate() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.date;
  }

  bool isEmail() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.email;
  }

  bool isNonce() {
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.nonce;
  }

  bool isPhoto(){
    return type == SchemaType.string &&
        schemaMap.containsKey(_subTypeKey) &&
        schemaMap[_subTypeKey] == _SubTypes.photo;
  }

  bool isObject() {
    return type == SchemaType.object;
  }

  Optional<FormFieldValidator> getValidators() {
    final validators = <FieldValidator>[];
    final debug = <String>[];

    if (parent != null && parent.requiredProperties.contains(propertyName)){
      if (isString() || isDate() || isEmail() || isNonce()) {
        validators.add(RequiredValidator(errorText: 'Required'));
        debug.add('required');
      }
      else if (isPhoto()) {
        validators.add(NotNullOrEmptyValidator<File>(errorText: 'Required'));
        debug.add('required');
      }
      else {
        _log.error('Field ${propertyName} has a type ${type}, which has no required validator implemented. Schema: $this');
      }
    }

    if (minLength != null) {
      validators.add(MinLengthValidator(minLength, errorText: 'Min length is ${minLength}'));
      debug.add('minLength');
    }

    if (maxLength != null) {
      validators.add(MaxLengthValidator(maxLength, errorText: 'Max length is ${maxLength}'));
      debug.add('maxLength');
    }

    final rangeValidator = _getNumericRangeValidator(this);
    if (rangeValidator.isPresent){
      validators.add(rangeValidator.value);
      debug.add('range');
    }

    if (pattern != null){
      validators.add(PatternValidator(pattern.pattern, errorText: 'Invalid pattern'));
      debug.add('pattern');
    }

    _log.debug('[Validation] ${propertyName} got validators attached: ${debug.join(', ')}');
    return validators.isEmpty ? Optional.empty() : Optional.of(MultiValidator(validators));
  }
}

Optional<FieldValidator> _getNumericRangeValidator(JsonSchema schema){
  if (schema.minimum == null && schema.maximum == null) {
    return Optional.empty();
  }
  else if (schema.minimum != null && schema.maximum == null) {
    return Optional.of(MinValidator(schema.minimum, errorText: 'Must be greater than or equal to ${schema.minimum}'));
  }
  else if (schema.minimum == null && schema.maximum != null) {
    return Optional.of(MaxValidator(schema.maximum, errorText: 'Must be less than or equal to ${schema.maximum}'));
  }
  else {
    return Optional.of(RangeValidator(
      min: schema.minimum,
      max: schema.maximum,
      errorText: 'Must be between ${schema.minimum} and ${schema.maximum}'
    ));
  }
}