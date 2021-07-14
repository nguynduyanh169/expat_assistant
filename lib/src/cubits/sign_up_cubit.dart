import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/sign_up_state.dart';
import 'package:expat_assistant/src/utils/email_utils.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState(status: SignUpStatus.init));

  Future<void> addFullnameAndPhone() async {
    emit(state.copyWith(status: SignUpStatus.addFullnameAndPhone));
  }

  Future<void> addLanguageAndNation() async {
    emit(state.copyWith(status: SignUpStatus.addLanguageAndNation));
  }

  Future<void> addEmailAndPassword() async {
    emit(state.copyWith(status: SignUpStatus.addEmailAndPassword));
  }

  Future<void> confirmEmail() async {
    bool check = await EmailUtils().sendMail();
    emit(state.copyWith(status: SignUpStatus.confirmEmail));
  }
}
