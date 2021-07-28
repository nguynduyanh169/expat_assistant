import 'package:equatable/equatable.dart';

enum SignUpStatus {
  init,
  addFullnameAndPhone,
  addLanguageAndNation,
  addEmailAndPassword,
  confirmEmail,
  sendingConfirmEmail,
  sendConfirmEmailFailed,
  signingUp,
  signUpSuccess,
  signUpFailed
}

extension Explaination on SignUpStatus {
  bool get isInit => this == SignUpStatus.init;

  bool get isAddFullnameAndPhone => this == SignUpStatus.addFullnameAndPhone;

  bool get isAddLanguageAndNation => this == SignUpStatus.addLanguageAndNation;

  bool get isAddEmailAndPassword => this == SignUpStatus.addEmailAndPassword;

  bool get isConfirmEmail => this == SignUpStatus.confirmEmail;

  bool get isSendingConfirmEmail => this == SignUpStatus.sendingConfirmEmail;

  bool get isSendConfirmEmailFailed =>
      this == SignUpStatus.sendConfirmEmailFailed;

  bool get isSigningUp => this == SignUpStatus.signingUp;

  bool get isSignUpSuccess => this == SignUpStatus.signUpSuccess;

  bool get isSignUpFailed => this == SignUpStatus.signUpFailed;
}

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String message;
  final int code;

  const SignUpState({this.status, this.message, this.code});

  @override
  // TODO: implement props
  List<Object> get props => [status, message, code];

  SignUpState copyWith({SignUpStatus status, String message, int code}) {
    return SignUpState(
        status: status ?? this.status,
        message: message ?? this.message,
        code: code ?? this.code);
  }
}
