import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/sign_up_state.dart';
import 'package:expat_assistant/src/utils/email_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpCubit extends Cubit<SignUpState> {
  UserRepository _userRepository;
  SignUpCubit(this._userRepository)
      : super(const SignUpState(status: SignUpStatus.init));

  Future<void> addFullnameAndPhone() async {
    emit(state.copyWith(status: SignUpStatus.addFullnameAndPhone));
  }

  Future<void> addLanguageAndNation() async {
    emit(state.copyWith(status: SignUpStatus.addLanguageAndNation));
  }

  Future<void> addEmailAndPassword() async {
    emit(state.copyWith(status: SignUpStatus.addEmailAndPassword));
  }

  Future<void> confirmEmail(String email) async {
    emit(state.copyWith(status: SignUpStatus.sendingConfirmEmail));
    try {
      Map<String, dynamic> check = await EmailUtils().sendMail(email);
      if (check['message'] == 0) {
        emit(state.copyWith(status: SignUpStatus.sendConfirmEmailFailed));
      } else {
        emit(state.copyWith(
            status: SignUpStatus.confirmEmail, code: check['message']));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: SignUpStatus.sendConfirmEmailFailed));
    }
  }

  Future<void> signUp(Expat expat) async {
    emit(state.copyWith(status: SignUpStatus.signingUp));
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: expat.email, password: expat.password);
      if (userCredential != null) {
        var result = await _userRepository.signUp(expat: expat);
        if (result == "Account duplicate!") {
          emit(state.copyWith(
              status: SignUpStatus.signUpFailed,
              message: 'Account ${expat.email} has exist!'));
        } else if (result == null) {
          emit(state.copyWith(
              status: SignUpStatus.signUpFailed,
              message: 'Create account failed!'));
        } else {
          emit(state.copyWith(
              status: SignUpStatus.signUpSuccess,
              message: "Created account successfully!"));
        }
      } else {
        emit(state.copyWith(status: SignUpStatus.signUpFailed));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: SignUpStatus.signUpFailed, message: e.toString()));
    }
  }
}
