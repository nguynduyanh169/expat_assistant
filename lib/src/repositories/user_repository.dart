import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/models/login_response.dart';
import 'package:expat_assistant/src/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<LoginResponse> login(
      {@required String email, @required String password}) {
    return _userProvider.login(email: email, password: password);
  }

  Future<dynamic> signUp({@required Expat expat}) {
    return _userProvider.signUp(expat: expat);
  }

  Future<Profile> getExpatProfile(
      {@required String token, @required String email}) {
    return _userProvider.getExpatProfile(token: token, email: email);
  }

  Future<dynamic> editExpatProfile(
      {@required String token, @required int expatId, @required Expat expat}) {
    return _userProvider.editExpatProfile(
        token: token, expatId: expatId, expat: expat);
  }

  Future<dynamic> changePassword(
      {@required String email, @required String newPassword}) {
    return _userProvider.changePassword(email: email, newPassword: newPassword);
  }
}
