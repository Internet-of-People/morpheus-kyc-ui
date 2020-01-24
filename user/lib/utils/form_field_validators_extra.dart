import 'package:form_field_validator/form_field_validator.dart';

class MinValidator extends TextFieldValidator {
  final num min;

  MinValidator(this.min, {String errorText})
      : super(errorText);

  @override
  bool isValid(String value) {
    try {
      final numericValue = num.parse(value);
      return (numericValue >= min);
    } catch (_) {
      return false;
    }
  }
}

class MaxValidator extends TextFieldValidator {
  final num max;

  MaxValidator(this.max, {String errorText})
      : super(errorText);

  @override
  bool isValid(String value) {
    try {
      final numericValue = num.parse(value);
      return (numericValue <= max);
    } catch (_) {
      return false;
    }
  }
}