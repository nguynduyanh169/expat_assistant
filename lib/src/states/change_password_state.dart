import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/old_password_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:formz/formz.dart';

class ChangePasswordState extends Equatable {
  final FormzStatus status;
  final String message;
  final PasswordValidate password;
  final OldPasswordValidate oldPassword;

  const ChangePasswordState(
      {this.oldPassword = const OldPasswordValidate.pure(),
      this.password = const PasswordValidate.pure(),
      this.status = FormzStatus.pure,
      this.message});

  @override
  // TODO: implement props
  List<Object> get props => [status, message, password, oldPassword];

  ChangePasswordState copyWith(
      {String message,
      FormzStatus status,
      PasswordValidate password,
      OldPasswordValidate oldPassword}) {
    return ChangePasswordState(
        message: message ?? this.message,
        status: status ?? this.status,
        password: password ?? this.password,
        oldPassword: oldPassword ?? this.oldPassword);
  }
}
