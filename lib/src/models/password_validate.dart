import 'package:formz/formz.dart';

enum PasswordValidationError{
  invalid,
  empty
}
class PasswordValidate extends FormzInput<String, PasswordValidationError>{
  const PasswordValidate.pure(): super.pure('');
  const PasswordValidate.dirty(String value) : super.dirty(value);
  // static final _passwordRegExp = RegExp(
  //     r'^[A-Za-z\d@$!%*?&]{8,}$'
  // );
  @override
  PasswordValidationError validator(String value) {
    if(value.isEmpty){
      return PasswordValidationError.empty;
    }
    return value.length > 5 ? null : PasswordValidationError.invalid;
  }


}

extension Explanation on PasswordValidationError {
  String get name {
    switch(this) {
      case PasswordValidationError.invalid:
        return "Password must be valid";
      default:
        return null;
    }
  }
}