import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;

  const ForgetPasswordState({this.status});

  @override
  // TODO: implement props
  List<Object> get props => [status];

  ForgetPasswordState copyWith({ForgetPasswordStatus status}) {
    return ForgetPasswordState(status: status ?? this.status);
  }
}

enum ForgetPasswordStatus {
  init,
  sendingEmail,
  sendEmailSuccess,
  sendEmailFailed,
  changeEmail
}

extension Explaination on ForgetPasswordStatus {
  bool get isInit => this == ForgetPasswordStatus.init;

  bool get isSendingEmail => this == ForgetPasswordStatus.sendingEmail;

  bool get isSendEmailSuccess => this == ForgetPasswordStatus.sendEmailSuccess;

  bool get isSendEmailFailed => this == ForgetPasswordStatus.sendEmailFailed;

  bool get isChangeEmail => this == ForgetPasswordStatus.changeEmail;
}
