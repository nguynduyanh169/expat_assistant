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
      List<ExpatAppointment> appointments = await _appointmentRepository
          .getAppointmentsByExpat(token: token, expatId: expatId);
      if (appointments == null) {
        emit(state.copyWith(
            status: TodayAppointmentStatus.loadAppointmentError));
      } else if (appointments.isEmpty) {
        emit(
            state.copyWith(status: TodayAppointmentStatus.loadedNoAppointment));
      } else {
        ExpatAppointment appointment = _getAppointment(appointments);
        if (appointment == null) {
          emit(state.copyWith(
              status: TodayAppointmentStatus.loadedNoAppointment));
        } else {
          emit(state.copyWith(
              status: TodayAppointmentStatus.loadedAppointment,
              appointment: appointment));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: TodayAppointmentStatus.loadAppointmentError));
    }
  }

  ExpatAppointment _getAppointment(List<ExpatAppointment> appointments) {
    DateTime now = DateTime.now();
    List<ExpatAppointment> nextAppointments = [];
    for (ExpatAppointment appointment in appointments) {
      if (DateTime(
              appointment.session.startTime[0],
              appointment.session.startTime[1],
              appointment.session.startTime[2],
              appointment.session.startTime[3],
              appointment.session.startTime[4])
          .isAfter(now)) {
        nextAppointments.add(appointment);
      }
    }
    nextAppointments.sort((a, b) => DateTime(
            a.session.startTime[0],
            a.session.startTime[1],
            a.session.startTime[2],
            a.session.startTime[3],
            a.session.startTime[4])
        .compareTo(DateTime(
            a.session.startTime[0],
            a.session.startTime[1],
            a.session.startTime[2],
            a.session.startTime[3],
            a.session.startTime[4])));
    var nextAppointment;
    if (nextAppointments.length != 0) {
      nextAppointment = nextAppointments.last;
    }

    return nextAppointment;
  }
}
