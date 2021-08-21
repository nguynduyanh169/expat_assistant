import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/models/login_response.dart';
import 'package:flutter/material.dart';

class UserProvider {
  final Dio _dio = Dio();

  Future<LoginResponse> login(
      {@required String email, @required String password}) async {
    LoginResponse loginResponse;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json"
      };

      Map<String, String> body = {'email': email, 'password': password};
      Response response = await _dio.post(ApiName.LOGIN_API,
          options: Options(headers: headers), data: json.encode(body));
      loginResponse = LoginResponse.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return loginResponse;
  }

  Future<dynamic> signUp({@required Expat expat}) async {
    LoginResponse loginResponse;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json"
      };
      Response response = await _dio.post(ApiName.SIGN_UP.trim(),
          options: Options(headers: headers), data: expat.toJson());
      loginResponse = LoginResponse.fromJson(response.data);
      print('Response: ' + loginResponse.toJson().toString());
    } catch (e) {
      if (e.toString().contains('412')) {
        return "Account duplicate!";
      }
      print(e.toString());
    }
    return loginResponse;
  }

  Future<Profile> getExpatProfile(
      {@required String token, @required String email}) async {
    Profile profile;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token'
      };
      Response response = await _dio.get(
          ApiName.GET_PROFILE_EXPAT + "?email=$email",
          options: Options(headers: headers));
      profile = Profile.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return profile;
  }

  Future<dynamic> editExpatProfile(
      {@required String token,
      @required int expatId,
      @required Expat expat}) async {
    ExpatProfile profile;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token'
      };
      Response response = await _dio.put(
          ApiName.EDIT_PROFILE + expatId.toString(),
          options: Options(headers: headers),
          data: expatToJson(expat));
      profile = ExpatProfile.fromJson(response.data);
    } on Exception catch (e) {
      print(e.toString());
    }
    return profile;
  }

  Future<dynamic> changePassword(
      {@required String email, @required String newPassword}) async {
    String result;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "text/plain;charset=ISO-8859-1",
      };
      Response response = await _dio.put(
          ApiName.CHANGE_PASSWORD + "?email=$email&password=$newPassword",
          options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 200) {
        result = response.data;
      }
      print(result);
    } catch (e) {
      print(e);
    }
    return result;
  }
}
