import 'package:expat_assistant/src/models/notification.dart';
import 'package:expat_assistant/src/providers/appointment_provider.dart';
import 'package:flutter/cupertino.dart';

class AppointmentRepository {
  final AppointmentProvider _appointmentProvider = AppointmentProvider();

  Future<dynamic> registrySession(
      {@required String token,
      @required int expatId,
      @required int sessionId,
      @required int majorId,
      @required String channelName}) {
    return _appointmentProvider.registrySession(
        token: token,
        expatId: expatId,
        majorId: majorId,
        sessionId: sessionId,
        channelName: channelName);
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

  Future<dynamic> feedbackAppointment(
      {@required String token,
      @required double rating,
      @required String comment,
      @required int appointmentId}) {
    return _appointmentProvider.feedbackAppointment(
        token: token,
        rating: rating,
        comment: comment,
        appointmentId: appointmentId);
  }

  Future<String> generateToken(
      {@required int uid,
      @required String channelName,
      @required String token,
      @required int expiredTime,
      @required int role}) {
    return _appointmentProvider.generateToken(
        uid: uid,
        channelName: channelName,
        token: token,
        expiredTime: expiredTime,
        role: role);
  }

  Future<NotificationReceive> sendNotification(
      {@required NotificationSend notificationSend}) {
    return _appointmentProvider.sendNotification(
        notificationSend: notificationSend);
  }
}
