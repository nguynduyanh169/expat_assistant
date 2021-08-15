import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/upcoming_appointment_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class UpcomingAppointmentCubit extends Cubit<UpcomingAppointmentState> {
  AppointmentRepository _appointmentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  UpcomingAppointmentCubit(this._appointmentRepository)
      : super(const UpcomingAppointmentState(
            status: UpcomingAppointmentStatus.init));

  Future<void> getAppointments() async {
    emit(state.copyWith(status: UpcomingAppointmentStatus.loadingAppointments));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      List<ExpatAppointment> appointments = await _appointmentRepository
          .getAppointmentsByExpat(token: token, expatId: expatId);
      if (appointments.isEmpty) {
        emit(state.copyWith(
            status: UpcomingAppointmentStatus.loadAppointmentsFailed));
      } else {
        ExpatAppointment appointment = _getAppointment(appointments);
        emit(state.copyWith(
            status: UpcomingAppointmentStatus.loadedAppointments,
            appointments: appointments,
            todayAppointment: appointment));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: UpcomingAppointmentStatus.loadAppointmentsFailed));
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
    final nextAppointment = nextAppointments.last;
    return nextAppointment;
  }
}
