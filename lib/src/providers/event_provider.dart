import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:flutter/material.dart';

class EventProvider {
  final Dio _dio = Dio();

  Future<Event> getEventsPagingation(
      {@required int page, @required String token}) async {
    int limit = 3;
    Event result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_EVENTS_PAGINGATION +
              "?page=$page&size=$limit&sortBy=eventId",
          options: Options(headers: headers));
      result = Event.fromJson(response.data);
    }on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
