import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class HiveUtils {
  bool haveToken({@required String boxName}) {
    final openBox = Hive.box(boxName);
    Map<dynamic, dynamic> userAuth = openBox.get('userAuth');
    return userAuth != null;
  }

  addUserAuth(
      {@required String email,
      @required String token,
      @required String boxName}) {
    final openBox = Hive.box(boxName);
    openBox.put('userAuth', {'email': email, 'token': token});
  }

  deleteUserAuth({@required String boxName}) {
    final openBox = Hive.box(boxName);
    openBox.delete('userAuth');
  }
}
