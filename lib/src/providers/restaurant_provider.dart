import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:flutter/material.dart';

class RestaurantProvider {
  final Dio _dio = Dio();

  Future<dynamic> detectFood({@required String imageUrl}) async {
    String result;
    String url = 'http://192.168.1.8:5000/detectFood';
    try {
      Map<String, String> data = {'image_link': imageUrl};
      Response response = await _dio.post(url, data: FormData.fromMap(data));
      if (response.statusCode == 200) {
        result = response.data;
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<LocationList> getNearbyRestaurant({@required String location}) async {
    LocationList result;
    String url = 'http://192.168.1.8:5000/restaurants';
    try {
      Map<String, String> data = {'location': location};
      Response response = await _dio.post(url, data: FormData.fromMap(data));
      if (response.statusCode == 200) {
        result = LocationList.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<LocationList> getNextRestaurant(
      {@required String nextPageToken}) async {
    LocationList result;
    String url = 'http://192.168.1.8:5000/restaurants/nextPage';
    try {
      Map<String, String> data = {'next_page_token': nextPageToken};
      Response response = await _dio.post(url, data: FormData.fromMap(data));
      if (response.statusCode == 200) {
        result = LocationList.fromJson(response.data);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
