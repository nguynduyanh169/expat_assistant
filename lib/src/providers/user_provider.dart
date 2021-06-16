import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
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
}
