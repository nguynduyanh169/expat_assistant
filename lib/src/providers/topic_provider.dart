import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:flutter/material.dart';

class TopicProvider {
  final Dio _dio = Dio();

  Future<List<Topic>> getAllTopic({@required String token}) async {
    List<Topic> topics;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token'
      };
      Response response = await _dio.get(ApiName.FIND_ALL_TOPICS,
          options: Options(headers: headers));
      topics = (response.data as List<dynamic>)
          .map((i) => Topic.fromJson(i))
          .toList()
          .cast<Topic>();
    }catch (e) {
      print(e.toString());
    }
    return topics;
  }
}
