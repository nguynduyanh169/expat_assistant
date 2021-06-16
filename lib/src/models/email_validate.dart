import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class EmailValidate extends FormzInput<String, EmailValidationError>{
  const EmailValidate.pure(): super.pure('');
  const EmailValidate.dirty([String value = '']): super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

extension Explanation on EmailValidationError {
  String get name {
    switch(this) {
      case EmailValidationError.invalid:
        return "Email must be valid";
      default:
        return null;
    }
  }
}