import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/old_password_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/change_password_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  UserRepository _userRepository;
  HiveUtils _hiveUtils = HiveUtils();
  ChangePasswordCubit(this._userRepository)
      : super(const ChangePasswordState());

  void passwordChanged(String value) {
    final password = PasswordValidate.dirty(value);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([password, state.oldPassword])));
  }

  void oldPasswordChanged(String value) {
    final oldPassword = OldPasswordValidate.dirty(value);
    emit(state.copyWith(
        oldPassword: oldPassword,
        status: Formz.validate([oldPassword, state.password])));
  }

  Future<void> changePassword(String newPassword) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String email = loginResponse['email'].toString();
      String result = await _userRepository.changePassword(
          email: email, newPassword: newPassword);
      print("error " + result);
      if (result == null) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            message: 'An error occurs while changing password'));
      } else if (result == "Email doesn't exist") {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, message: result));
      } else if (result == "Password updated!") {
        await FirebaseAuth.instance.currentUser.updatePassword(newPassword);
        _hiveUtils.editPassword(newPassword: newPassword);
        emit(state.copyWith(
            status: FormzStatus.submissionSuccess, message: result));
      }
    } on Exception catch (e) {
      print('error' + e.toString());
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }
}
