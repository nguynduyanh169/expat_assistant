import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/location.dart';
import 'package:flutter/material.dart';

class LocationProvider {
  final Dio _dio = Dio();

  Future<List<Location>> getLocationsByEventId(
      {@required String token, @required int eventId}) async {
    List<Location> result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_LOCATIONS_BY_EVENTID + eventId.toString(),
          options: Options(headers: headers));
      result = (response.data as List<dynamic>)
          .map((i) => Location.fromJson(i))
          .toList()
          .cast<Location>();
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
