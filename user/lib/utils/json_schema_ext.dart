import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/utils/form_field_validators_extra.dart';
import 'package:optional/optional.dart';

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

  Optional<FormFieldValidator> getValidators() {
    final List<FieldValidator> validators = [];

    if(this.parent != null && this.parent.requiredProperties.contains(this.propertyName)){
      validators.add(RequiredValidator(errorText: 'Required'));
    }

    if(this.minLength != null) {
      validators.add(MinLengthValidator(this.minLength, errorText: 'Min length is ${this.minLength}'));
    }

    if(this.maxLength != null) {
      validators.add(MaxLengthValidator(this.maxLength, errorText: 'Max length is ${this.maxLength}'));
    }

    final rangeValidator = _getNumericRangeValidator(this);
    if(rangeValidator.isPresent){
      validators.add(rangeValidator.value);
    }

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