import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/invoice_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  AppointmentRepository _appointmentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  InvoiceCubit(this._appointmentRepository)
      : super(const InvoiceState(status: InvoiceStatus.init));

  Future<void> registrySessions(List<SessionDisplay> sessions) async {
    emit(state.copyWith(status: InvoiceStatus.registrying));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      print(expatId);
      for (SessionDisplay session in sessions) {
        Appointment appointment = await _appointmentRepository.registrySession(
            token: token, expatId: expatId, sessionId: session.sessionId);
        if (appointment == null) {
          emit(state.copyWith(
              status: InvoiceStatus.registryFailed, message: 'error'));
        }
      }
      emit(state.copyWith(status: InvoiceStatus.registrySuccess));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: InvoiceStatus.registryFailed, message: e.toString()));
    }
  }
}
