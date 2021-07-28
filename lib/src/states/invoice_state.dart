import 'package:equatable/equatable.dart';

class InvoiceState extends Equatable {
  final String message;
  final InvoiceStatus status;

  const InvoiceState({this.message, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [message, status];

  InvoiceState copyWith({String message, InvoiceStatus status}) {
    return InvoiceState(
        message: message ?? this.message, status: status ?? this.status);
  }
}

enum InvoiceStatus { registrying, registrySuccess, registryFailed, init }

extension Explaination on InvoiceStatus {
  bool get isInit => this == InvoiceStatus.init;

  bool get isRegistryingSession => this == InvoiceStatus.registrying;

  bool get isRegistryingSessionSuccess => this == InvoiceStatus.registrySuccess;

  bool get isRegistryingSessionFailed => this == InvoiceStatus.registryFailed;
}
