import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/email_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  final EmailValidate email;
  final PasswordValidate password;
  final FormzStatus status;
  final String exceptionError;

  const LoginState(
      {this.email = const EmailValidate.pure(),
      this.password = const PasswordValidate.pure(),
      this.status = FormzStatus.pure,
      this.exceptionError});

  @override
  // TODO: implement props
  List<Object> get props => [email, password, status, exceptionError];

  LoginState copyWith(
      {EmailValidate email,
      PasswordValidate password,
      FormzStatus status,
      String error}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        exceptionError: error ?? this.exceptionError);
  }
}
