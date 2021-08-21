import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/forget_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit()
      : super(const ForgetPasswordState(status: ForgetPasswordStatus.init));

  Future<void> sendEmail(String email) async {
    emit(state.copyWith(status: ForgetPasswordStatus.sendingEmail));
    try {
      var acs = ActionCodeSettings(
          url: 'https://expat-assist.firebase.com',
          handleCodeInApp: true,
          androidPackageName: 'com.capstone.expat_assistant',
          androidInstallApp: true,
          androidMinimumVersion: '21');
      await FirebaseAuth.instance
          .sendSignInLinkToEmail(email: email, actionCodeSettings: acs);
      
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: ForgetPasswordStatus.sendEmailFailed));
    }
  }
}
