import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/payment_result.dart';

class WalletState extends Equatable {
  final List<PaymentView> paymentLists;
  final String message;
  final WalletStatus status;

  const WalletState({this.message, this.paymentLists, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [message, paymentLists, status];

  WalletState copyWith(
      {List<PaymentView> paymentLists, String message, WalletStatus status}) {
    return WalletState(
        paymentLists: paymentLists ?? this.paymentLists,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}

enum WalletStatus { init, loadingWallet, loadedWallet, loadWalletError }

extension Explaination on WalletStatus {
  bool get isInit => this == WalletStatus.init;

  bool get isLoadingWallet => this == WalletStatus.loadingWallet;

  bool get isLoadWalletSuccess => this == WalletStatus.loadedWallet;

  bool get isLoadWalletError => this == WalletStatus.loadWalletError;
}
