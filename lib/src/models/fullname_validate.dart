import 'package:formz/formz.dart';

class FullnameValidate extends FormzInput<String, FullNameValidateError> {
  const FullnameValidate.pure() : super.pure('');
  const FullnameValidate.dirty(String value) : super.dirty(value);

  @override
  FullNameValidateError validator(String value) {
    return value.length > 3 ? null : FullNameValidateError.invalid;
  }
}

enum FullNameValidateError { invalid }

extension Explanation on FullNameValidateError {
  String get name {
    switch (this) {
      case FullNameValidateError.invalid:
        return "Full name must be valid";
      default:
        return null;
    }
  }
}
