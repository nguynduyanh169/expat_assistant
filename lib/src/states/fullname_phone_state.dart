import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/fullname_validate.dart';
import 'package:expat_assistant/src/models/phone_validate.dart';
import 'package:formz/formz.dart';

class FullnamePhoneState extends Equatable {
  final FullnameValidate fullname;
  final PhoneValidate phone;
  final FormzStatus status;
  final String error;

  const FullnamePhoneState({
    this.fullname = const FullnameValidate.pure(),
    this.error,
    this.phone = const PhoneValidate.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  // TODO: implement props
  List<Object> get props => [fullname, phone, status, error];

  FullnamePhoneState copyWith(
      {FullnameValidate fullname,
      PhoneValidate phone,
      FormzStatus status,
      String error}) {
    return FullnamePhoneState(
        fullname: fullname ?? this.fullname,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        error: error ?? this.error);
  }
}
