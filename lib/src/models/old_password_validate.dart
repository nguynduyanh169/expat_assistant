import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:formz/formz.dart';

enum OldPasswordValidateError { invalid, empty }

class OldPasswordValidate extends FormzInput<String, OldPasswordValidateError> {
  const OldPasswordValidate.pure() : super.pure('');
  const OldPasswordValidate.dirty([String value = '']) : super.dirty(value);
  @override
  OldPasswordValidateError validator(String value) {
    HiveUtils _hiveUtils = HiveUtils();
    Map<dynamic, dynamic> loginResponse =
        _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
    String oldPassword = loginResponse['password'].toString();
    if (value.isEmpty || value == '') {
      return OldPasswordValidateError.empty;
    }
    return value == oldPassword ? null : OldPasswordValidateError.invalid;
  }
}

extension Explanation on OldPasswordValidateError {
  String get name {
    switch (this) {
      case OldPasswordValidateError.invalid:
        return "Old password is wrong";
      case OldPasswordValidateError.empty:
        return "Old password is required";
      default:
        return null;
    }
  }
}
