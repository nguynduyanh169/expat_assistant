import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/fullname_validate.dart';
import 'package:expat_assistant/src/models/phone_validate.dart';
import 'package:expat_assistant/src/states/fullname_phone_state.dart';
import 'package:formz/formz.dart';

class FullnamePhoneCubit extends Cubit<FullnamePhoneState> {
  FullnamePhoneCubit() : super(const FullnamePhoneState());

  void fullnameChange(String value) {
    final fullname = FullnameValidate.dirty(value);
    emit(state.copyWith(
        fullname: fullname, status: Formz.validate([fullname, state.phone])));
  }

  void phoneChange(String value) {
    final phone = PhoneValidate.dirty(value);
    emit(state.copyWith(
        phone: phone, status: Formz.validate([phone, state.fullname])));
  }
}
