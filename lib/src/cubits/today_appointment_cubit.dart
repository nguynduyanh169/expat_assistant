import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/today_appointment_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class TodayAppointmentCubit extends Cubit<TodayAppointmentState> {
  AppointmentRepository _appointmentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  TodayAppointmentCubit(this._appointmentRepository)
      : super(const TodayAppointmentState(status: TodayAppointmentStatus.init));

  Future<void> getTodayAppointment() async {
    emit(state.copyWith(status: TodayAppointmentStatus.loadingAppointment));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      List<Appointment> appointments = await _appointmentRepository
          .getAppointmentsByExpat(token: token, expatId: expatId);
      if (appointments.isEmpty) {
        emit(state.copyWith(
            status: TodayAppointmentStatus.loadAppointmentError));
      } else {
        Appointment appointment = _getAppointment(appointments);
        emit(state.copyWith(
            status: TodayAppointmentStatus.loadedAppointment,
            appointment: appointment));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: TodayAppointmentStatus.loadAppointmentError));
    }
  }

  Appointment _getAppointment(List<Appointment> appointments) {
    return appointments.first;
  }
}
