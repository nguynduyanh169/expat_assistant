import 'package:expat_assistant/src/providers/appointment_provider.dart';
import 'package:flutter/cupertino.dart';

class AppointmentRepository {
  final AppointmentProvider _appointmentProvider = AppointmentProvider();

  Future<dynamic> registrySession(
      {@required String token,
      @required int expatId,
      @required int sessionId}) {
    return _appointmentProvider.registrySession(
        token: token, expatId: expatId, sessionId: sessionId);
  }

  Future<dynamic> getAppointmentsByExpat(
      {@required String token, @required int expatId}) {
    return _appointmentProvider.getAppointmentsByExpat(
        token: token, expatId: expatId);
  }

  Future<dynamic> getAppointmentsById(
      {@required String token, @required int appointmentId}) {
    return _appointmentProvider.getAppointmentById(
        token: token, appointmentId: appointmentId);
  }
}
