import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/email_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:formz/formz.dart';

class EmailPasswordState extends Equatable {
  final EmailValidate email;
  final PasswordValidate password;
  final FormzStatus status;
  final String error;

  const EmailPasswordState({
    this.email = const EmailValidate.pure(),
    this.error,
    this.password = const PasswordValidate.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  // TODO: implement props
  List<Object> get props => [email, password, status, error];

  EmailPasswordState copyWith(
      {EmailValidate email,
      PasswordValidate password,
      FormzStatus status,
      String error}) {
    return EmailPasswordState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        error: error ?? this.error);
  }
}
