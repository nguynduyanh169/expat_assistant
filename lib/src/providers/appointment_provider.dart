import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentProvider {
  final Dio _dio = Dio();

  Future<dynamic> registrySession(
      {@required String token,
      @required int expatId,
      @required int sessionId}) async {
    Appointment appointment;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };

      Response response = await _dio.post(
          ApiName.REGISTRY_SESSION + "?expatId=$expatId&sessionId=$sessionId",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        appointment = Appointment.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return appointment;
  }

  Future<dynamic> getAppointmentsByExpat(
      {@required String token, @required int expatId}) async {
    List<Appointment> appointments;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_APPOINTMENT_BY_EXPAT + "?expatId=$expatId",
          options: Options(headers: headers));
      print(response.data);
      appointments = (response.data as List<dynamic>)
          .map((i) => Appointment.fromJson(i))
          .toList()
          .cast<Appointment>();
      print('hello');
    } catch (e) {
      print(e.toString());
    }
    return appointments;
  }
}
