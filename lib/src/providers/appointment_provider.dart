import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentProvider {
  final Dio _dio = Dio();

  Future<dynamic> getAppointmentById(
      {@required String token, @required int appointmentId}) async {
    ExpatAppointment appointment;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_APPOINTMENT_BY_ID + appointmentId.toString(),
          options: Options(headers: headers));
      appointment = ExpatAppointment.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return appointment;
  }

  Future<dynamic> registrySession(
      {@required String token,
      @required int expatId,
      @required int sessionId,
      @required String channelName}) async {
    ExpatAppointment appointment;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      print(ApiName.REGISTRY_SESSION +
          "?expatId=$expatId&sessionId=$sessionId&channelName=$channelName");
      Response response = await _dio.post(
          ApiName.REGISTRY_SESSION +
              "?expatId=$expatId&sessionId=$sessionId&channelName=$channelName",
          options: Options(headers: headers));
      print(response);
      if (response.statusCode == 200) {
        appointment = ExpatAppointment.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return appointment;
  }

  Future<dynamic> getAppointmentsByExpat(
      {@required String token, @required int expatId}) async {
    List<ExpatAppointment> appointments;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_APPOINTMENT_BY_EXPAT + "?expatId=$expatId",
          options: Options(headers: headers));
      appointments = (response.data as List<dynamic>)
          .map((i) => ExpatAppointment.fromJson(i))
          .toList()
          .cast<ExpatAppointment>();
    } catch (e) {
      print(e.toString());
    }
    return appointments;
  }

  Future<dynamic> feedbackAppointment(
      {@required String token,
      @required double rating,
      @required String comment,
      @required int appointmentId}) async {
    ExpatAppointment appointment;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.put(
          ApiName.FEEDBACK_APPOINTMENT +
              "?comment=$comment&conAppointmentId=$appointmentId&rating=$rating&sessionId=$appointmentId",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        appointment = ExpatAppointment.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return appointment;
  }
}
