import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/payment_result.dart';
import 'package:expat_assistant/src/repositories/payment_repository.dart';
import 'package:expat_assistant/src/states/wallet_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class WalletCubit extends Cubit<WalletState> {
  PaymentRepository _paymentRepository;
  HiveUtils _hiveUtils = HiveUtils();

  WalletCubit(this._paymentRepository)
      : super(const WalletState(status: WalletStatus.init));

  Future<void> getPaymentsHistory() async {
    emit(state.copyWith(status: WalletStatus.loadingWallet));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      List<PaymentView> result = await _paymentRepository.getPaymentsByExpatId(
          token: token, expatId: expatId);
      if (result == null) {
        emit(state.copyWith(
            status: WalletStatus.loadWalletError,
            message: 'An error occurs while loading payment history'));
      } else {
        result.sort((a, b) => DateTime(a.createDate[0], a.createDate[1],
                a.createDate[2], a.createDate[3], a.createDate[4])
            .compareTo(DateTime(b.createDate[0], b.createDate[1],
                b.createDate[2], b.createDate[3], b.createDate[4])));
        emit(state.copyWith(
            status: WalletStatus.loadedWallet,
            paymentLists: result.reversed.toList()));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: WalletStatus.loadWalletError, message: e.toString()));
    }
  }
}
