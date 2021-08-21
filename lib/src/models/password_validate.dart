import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

class PasswordValidate extends FormzInput<String, PasswordValidationError> {
  const PasswordValidate.pure() : super.pure('');
  const PasswordValidate.dirty(String value) : super.dirty(value);
  @override
  PasswordValidationError validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return value.length >= 6 ? null : PasswordValidationError.invalid;
  }
}

extension Explanation on PasswordValidationError {
  String get name {
    switch (this) {
      case PasswordValidationError.invalid:
        return "Password must be at least 6 characters";
      case PasswordValidationError.empty:
        return "Password is required";
      default:
        return null;
    }
  }
}
