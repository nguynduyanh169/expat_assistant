import 'package:equatable/equatable.dart';

class ConfirmEmailState extends Equatable {
  final int code;
  final String message;
  final ConfirmEmailStatus status;

  const ConfirmEmailState({this.code, this.message, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [code, message, status];

  ConfirmEmailState copyWith(
      {int code, String message, ConfirmEmailStatus status}) {
    return ConfirmEmailState(
        code: code ?? this.code,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}

enum ConfirmEmailStatus { init, resendCode, resendedCode, resendCodeError }

extension Explaination on ConfirmEmailStatus {
  bool get isInit => this == ConfirmEmailStatus.init;
  bool get isResendCode => this == ConfirmEmailStatus.resendCode;

  bool get isResendedCode => this == ConfirmEmailStatus.resendedCode;

  bool get isResendCodeError => this == ConfirmEmailStatus.resendCodeError;
}
