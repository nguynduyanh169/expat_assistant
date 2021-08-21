import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/notification.dart';
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
      print(response.data);
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
      @required int majorId,
      @required String channelName}) async {
    ExpatAppointment appointment;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      print(ApiName.REGISTRY_SESSION +
          "?channelName=$channelName&expatId=$expatId&majorId=$majorId&sessionId=$sessionId");
      Response response = await _dio.post(
          ApiName.REGISTRY_SESSION +
              "?channelName=$channelName&expatId=$expatId&majorId=$majorId&sessionId=$sessionId",
          options: Options(headers: headers));
      print(response.statusCode);
      if (response.statusCode == 200) {
        appointment = ExpatAppointment.fromJson(response.data);
      }
    } catch (e) {
      print('Error' + e.toString());
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
      print(ApiName.FEEDBACK_APPOINTMENT +
          "?comment=$comment&conAppointmentId=$appointmentId&rating=$rating&sessionId=$appointmentId");
      Response response = await _dio.put(
          ApiName.FEEDBACK_APPOINTMENT +
              "?comment=$comment&conAppointmentId=$appointmentId&rating=$rating&sessionId=$appointmentId",
          options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 200) {
        appointment = ExpatAppointment.fromJson(response.data);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return appointment;
  }

  Future<String> generateToken(
      {@required int uid,
      @required String channelName,
      @required String token,
      @required int expiredTime,
      @required int role}) async {
    String result;
    try {
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      Map<String, dynamic> data = {
        "channelName": channelName,
        "expirationTimeInSeconds": expiredTime,
        "role": role,
        "uid": uid
      };
      Response response = await _dio.post(ApiName.GET_AGORA_TOKEN,
          options: Options(headers: headers), queryParameters: data);
      if (response.statusCode == 200) {
        result = response.data["token"];
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<NotificationReceive> sendNotification(
      {@required NotificationSend notificationSend}) async {
    NotificationReceive result;
    try {
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ZDQwODY0MWYtNTEyYi00YTM1LWEyZTgtYWYxMjRmZTIxODI2',
      };
      Response response = await _dio.post(ApiName.SEND_NOTIFICATION,
          options: Options(headers: headers),
          data: notificationSendToJson(notificationSend));
      if (response.statusCode == 200) {
        result = NotificationReceive.fromJson(response.data);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
