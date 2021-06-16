import 'package:expat_assistant/src/models/login_response.dart';
import 'package:expat_assistant/src/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<LoginResponse> login({@required String email, @required String password}){
    return _userProvider.login(email: email, password: password);
  }
  
}