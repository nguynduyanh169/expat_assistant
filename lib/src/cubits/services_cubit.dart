import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/payment_result.dart';
import 'package:expat_assistant/src/repositories/payment_repository.dart';
import 'package:expat_assistant/src/states/services_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/utils/payment_utils.dart';

class ServicesCubit extends Cubit<ServiceState> {
  PaymentRepository _paymentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  ServicesCubit(this._paymentRepository)
      : super(const ServiceState(status: ServicesStatus.init));

  Future<void> getPaymentsHistory() async {
    emit(state.copyWith(status: ServicesStatus.init));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      List<PaymentView> result = await _paymentRepository.getPaymentsByExpatId(
          token: token, expatId: expatId);
      if (result == null) {
        emit(state.copyWith(
          status: ServicesStatus.loadError,
        ));
      } else {
        String totalPrice = PaymentUtils.caculateTotalInYear(result);
        emit(state.copyWith(
            status: ServicesStatus.loaded, totalPrice: totalPrice));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: ServicesStatus.loadError));
    }
  }
}
