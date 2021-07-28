import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/email_validate.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/models/login_response.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/login_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class LoginCubit extends Cubit<LoginState> {
  UserRepository _userRepository;
  HiveUtils _hiveUtils = HiveUtils();
  LoginCubit(this._userRepository) : super(const LoginState());

  void emailChanged(String value) {
    final email = EmailValidate.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = PasswordValidate.dirty(value);
    emit(state.copyWith(
        password: password, status: Formz.validate([password, state.email])));
  }

  Future<void> loginWithCredential(
      {@required String email, @required String password}) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        LoginResponse loginResponse =
            await _userRepository.login(email: email, password: password);
        if (loginResponse.token != 'Fail') {
          Profile profile = await _userRepository.getExpatProfile(
              token: loginResponse.token, email: email);
          _hiveUtils.addUserAuth(
              id: profile.expat.id,
              password: password,
              email: loginResponse.email,
              token: loginResponse.token,
              fullname: profile.expat.fullname,
              avatar: profile.expat.avatarLink,
              boxName: HiveBoxName.USER_AUTH);
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              error: 'Invalid email or password'));
        }
      } else {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            error: 'Invalid email or password'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, error: e.toString()));
    }
  }
}
