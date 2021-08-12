import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expat_assistant/src/models/location_details.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:flutter/material.dart';

class RestaurantProvider {
  final Dio _dio = Dio();

  Future<dynamic> detectFood({@required String imageUrl}) async {
    String result;
    String url = 'http://192.168.1.8:5000/food/detect';
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
    print(nextPageToken);
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

  Future<LocationDetails> getRestaurantDetails(
      {@required String placeId}) async {
    LocationDetails result;
    String url = 'http://192.168.1.8:5000/restaurantDetails';

    try {
      Map<String, String> data = {'place_id': placeId};
      Response response = await _dio.post(url, data: FormData.fromMap(data));
      if (response.statusCode == 200) {
        result = LocationDetails.fromJson(response.data);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<LocationList> getRestaurantByFoodName(
      {@required String foodName, @required String location}) async {
    LocationList result;
    String url = 'http://192.168.1.8:5000/restaurants/foodName';
    try {
      Map<String, String> data = {'location': location, 'name': foodName};
      Response response = await _dio.post(url, data: FormData.fromMap(data));
      if (response.statusCode == 200) {
        result = LocationList.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
