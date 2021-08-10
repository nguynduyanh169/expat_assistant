import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/payment.dart';
import 'package:mailer/mailer.dart';

class InvoiceState extends Equatable {
  final String message;
  final PaymentRespone paymentRespone;
  final InvoiceStatus status;

  const InvoiceState({this.message, this.status, this.paymentRespone});

  @override
  // TODO: implement props
  List<Object> get props => [message, status, paymentRespone];

  InvoiceState copyWith(
      {String message, InvoiceStatus status, PaymentRespone paymentRespone}) {
    return InvoiceState(
        message: message ?? this.message,
        status: status ?? this.status,
        paymentRespone: paymentRespone ?? this.paymentRespone);
  }
}

enum InvoiceStatus {
  registrying,
  registrySuccess,
  registryFailed,
  init,
  payingWithMomo,
  payWithMomoSuccess,
  payWithMomoFailed
}

extension Explaination on InvoiceStatus {
  bool get isInit => this == InvoiceStatus.init;

  bool get isRegistryingSession => this == InvoiceStatus.registrying;

  bool get isRegistryingSessionSuccess => this == InvoiceStatus.registrySuccess;

  bool get isRegistryingSessionFailed => this == InvoiceStatus.registryFailed;

  bool get isPayingWithMomo => this == InvoiceStatus.payingWithMomo;

  bool get isPayWithMomoSuccess => this == InvoiceStatus.payWithMomoSuccess;

  bool get isPayWithMomoFailed => this == InvoiceStatus.payWithMomoFailed;
}
