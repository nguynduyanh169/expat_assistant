import 'package:equatable/equatable.dart';

enum SignUpStatus {
  init,
  addFullnameAndPhone,
  addLanguageAndNation,
  addEmailAndPassword,
  confirmEmail
}

extension Explaination on SignUpStatus {
  bool get isInit => this == SignUpStatus.init;

  bool get isAddFullnameAndPhone => this == SignUpStatus.addFullnameAndPhone;

  bool get isAddLanguageAndNation => this == SignUpStatus.addLanguageAndNation;

  bool get isAddEmailAndPassword => this == SignUpStatus.addEmailAndPassword;

  bool get isConfirmEmail => this == SignUpStatus.confirmEmail;
}

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String message;

  const SignUpState({this.status, this.message});

  @override
  // TODO: implement props
  List<Object> get props => [status, message];

  SignUpState copyWith({SignUpStatus status, String message}) {
    return SignUpState(
        status: status ?? this.status, message: message ?? this.message);
  }
}
