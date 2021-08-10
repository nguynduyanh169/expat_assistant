import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/appointment.dart';

class TodayAppointmentState extends Equatable {
  final TodayAppointmentStatus status;
  final ExpatAppointment appointment;

  const TodayAppointmentState({this.appointment, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [appointment, status];

  TodayAppointmentState copyWith(
      {TodayAppointmentStatus status, ExpatAppointment appointment}) {
    return TodayAppointmentState(
        status: status ?? this.status,
        appointment: appointment ?? this.appointment);
  }
}

enum TodayAppointmentStatus {
  init,
  loadingAppointment,
  loadedAppointment,
  loadAppointmentError
}

extension Explanation on TodayAppointmentStatus {
  bool get isInit => this == TodayAppointmentStatus.init;

  bool get isLoadingAppointment =>
      this == TodayAppointmentStatus.loadingAppointment;

  bool get isLoadedAppointment =>
      this == TodayAppointmentStatus.loadedAppointment;

  bool get isLoadAppointmentError =>
      this == TodayAppointmentStatus.loadAppointmentError;
}
