import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/auth_status.dart';
import 'package:expat_assistant/src/states/authentication_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  HiveUtils _hiveUtils = HiveUtils();
  AuthenticationCubit() : super(const AuthenticationState());

  Future<void> checkLoggedIn() async {
    emit(state.copyWith(status: AuthenticationStatus.authenticating));
    Map<dynamic, dynamic> loginResponse =
        _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
    if (loginResponse == null) {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    } else {
      String email = loginResponse['email'];
      String password = loginResponse['password'];
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        emit(state.copyWith(
            loginResponse: loginResponse,
            status: AuthenticationStatus.authenticated));
      } else {
        emit(state.copyWith(
            loginResponse: loginResponse,
            status: AuthenticationStatus.unauthenticated));
      }
    }
  }
}
