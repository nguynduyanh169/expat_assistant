import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/confirm_email_state.dart';
import 'package:expat_assistant/src/utils/email_utils.dart';

class ConfirmEmailCubit extends Cubit<ConfirmEmailState> {
  ConfirmEmailCubit()
      : super(const ConfirmEmailState(status: ConfirmEmailStatus.init));

  Future<void> resendEmail(String email) async {
    emit(state.copyWith(status: ConfirmEmailStatus.resendedCode));
    try {
      Map<String, dynamic> check = await EmailUtils().sendMail(email);
      if (check['message'] == 0) {
        emit(state.copyWith(status: ConfirmEmailStatus.resendCodeError));
      } else {
        emit(state.copyWith(
          status: ConfirmEmailStatus.resendCode,
          code: check['message'],
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: ConfirmEmailStatus.resendCodeError));
    }
  }
}
