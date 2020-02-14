import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_common/utils/log.dart';
import 'package:morpheus_common/utils/schema_form/form_field_validators_extra.dart';
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
    return this.type == SchemaType.string && !this.schemaMap.containsKey(_subTypeKey);
  }

  bool isNumber() {
    return this.type == SchemaType.number;
  }

  bool isContentId() {
    return this.type == SchemaType.string &&
        this.schemaMap.containsKey(_subTypeKey) &&
        this.schemaMap[_subTypeKey] == _SubTypes.contentId;
  }

  bool isDate() {
    return this.type == SchemaType.string &&
        this.schemaMap.containsKey(_subTypeKey) &&
        this.schemaMap[_subTypeKey] == _SubTypes.date;
  }

  bool isEmail() {
    return this.type == SchemaType.string &&
        this.schemaMap.containsKey(_subTypeKey) &&
        this.schemaMap[_subTypeKey] == _SubTypes.email;
  }

  bool isNonce() {
    return this.type == SchemaType.string &&
        this.schemaMap.containsKey(_subTypeKey) &&
        this.schemaMap[_subTypeKey] == _SubTypes.nonce;
  }

  bool isPhoto(){
    return this.type == SchemaType.string &&
        this.schemaMap.containsKey(_subTypeKey) &&
        this.schemaMap[_subTypeKey] == _SubTypes.photo;
  }

  bool isObject() {
    return this.type == SchemaType.object;
  }

  Optional<FormFieldValidator> getValidators() {
    final List<FieldValidator> validators = [];
    final List<String> debug = [];

    if(this.parent != null && this.parent.requiredProperties.contains(this.propertyName)){
      if(this.isString() || this.isDate() || this.isEmail() || this.isNonce()) {
        validators.add(RequiredValidator(errorText: 'Required'));
        debug.add('required');
      }
      else if(this.isPhoto()) {
        validators.add(NotNullOrEmptyValidator<File>(errorText: 'Required'));
        debug.add('required');
      }
      else {
        _log.error('Field ${this.propertyName} has a type ${this.type}, which has no required validator implemented. Schema: $this');
      }
    }

    if(this.minLength != null) {
      validators.add(MinLengthValidator(this.minLength, errorText: 'Min length is ${this.minLength}'));
      debug.add('minLength');
    }

    if(this.maxLength != null) {
      validators.add(MaxLengthValidator(this.maxLength, errorText: 'Max length is ${this.maxLength}'));
      debug.add('maxLength');
    }

    final rangeValidator = _getNumericRangeValidator(this);
    if(rangeValidator.isPresent){
      validators.add(rangeValidator.value);
      debug.add('range');
    }

    if(this.pattern != null){
      validators.add(PatternValidator(this.pattern.pattern, errorText: 'Invalid pattern'));
      debug.add('pattern');
    }

    _log.debug('[Validation] ${this.propertyName} got validators attached: ${debug.join(', ')}');
    return validators.isEmpty ? Optional.empty() : Optional.of(MultiValidator(validators));
  }
}

Optional<FieldValidator> _getNumericRangeValidator(JsonSchema schema){
  if(schema.minimum == null && schema.maximum == null){
    return Optional.empty();
  }
  else if(schema.minimum != null && schema.maximum == null){
    return Optional.of(MinValidator(schema.minimum, errorText: 'Must be greater than or equal to ${schema.minimum}'));
  }
  else if(schema.minimum == null && schema.maximum != null){
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