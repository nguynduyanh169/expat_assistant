import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/major.dart';
import 'package:flutter/material.dart';

class MajorProvider {
  final Dio _dio = Dio();

  Future<dynamic> getMajors(
      {@required String token, @required int page}) async {
    List<Content> majors;
    int size = 5;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_MAJORS + "?page=$page&size=$size",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        majors = (response.data['content'] as List<dynamic>)
            .map((i) => Content.fromJson(i))
            .toList()
            .cast<Content>();
        print(majors.length);
      }
    } catch (e) {
      print(e.toString());
    }
    return majors;
  }

}
