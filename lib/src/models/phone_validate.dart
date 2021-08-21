import 'package:formz/formz.dart';

enum PhoneValidateError { invalid }

extension Explanation on PhoneValidateError {
  String get name {
    switch (this) {
      case PhoneValidateError.invalid:
        return "Phone number should be 10 digit number";
      default:
        return null;
    }
  }
}

class PhoneValidate extends FormzInput<String, PhoneValidateError> {
  const PhoneValidate.pure() : super.pure('');
  const PhoneValidate.dirty(String value) : super.dirty(value);

  static final RegExp _phoneRegex = RegExp(
    r'(84|0[3|5|7|8|9])+([0-9]{8})\b',
  );

  @override
  PhoneValidateError validator(String value) {
    return _phoneRegex.hasMatch(value) ? null : PhoneValidateError.invalid;
  }
}
