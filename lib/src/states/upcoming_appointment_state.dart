import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/appointment.dart';

class UpcomingAppointmentState extends Equatable {
  final UpcomingAppointmentStatus status;
  final List<ExpatAppointment> appointments;
  final ExpatAppointment todayAppointment;

  const UpcomingAppointmentState(
      {this.appointments, this.status, this.todayAppointment});

  @override
  // TODO: implement props
  List<Object> get props => [appointments, status];

  UpcomingAppointmentState copyWith(
      {UpcomingAppointmentStatus status,
      List<ExpatAppointment> appointments,
      ExpatAppointment todayAppointment}) {
    return UpcomingAppointmentState(
        status: status ?? this.status,
        appointments: appointments ?? this.appointments,
        todayAppointment: todayAppointment ?? this.todayAppointment);
  }
}

enum UpcomingAppointmentStatus {
  init,
  loadingAppointments,
  loadedAppointments,
  loadAppointmentsFailed,
  loadedNoAppointments,
}

extension Explaination on UpcomingAppointmentStatus {
  bool get isInit => this == UpcomingAppointmentStatus.init;

  bool get isLoadingAppointments =>
      this == UpcomingAppointmentStatus.loadingAppointments;

  bool get isLoadedAppointments =>
      this == UpcomingAppointmentStatus.loadedAppointments;

  bool get isLoadAppointmentsFailed =>
      this == UpcomingAppointmentStatus.loadAppointmentsFailed;

  bool get isLoadedNoAppointments =>
      this == UpcomingAppointmentStatus.loadedNoAppointments;
}
