import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/email_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:expat_assistant/src/states/email_password_state.dart';
import 'package:formz/formz.dart';

class EmailPasswordCubit extends Cubit<EmailPasswordState> {
  EmailPasswordCubit() : super(const EmailPasswordState());

  void emailChange(String value) {
    final email = EmailValidate.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChange(String value) {
    final password = PasswordValidate.dirty(value);
    emit(state.copyWith(
        password: password, status: Formz.validate([password, state.email])));
  }
}
