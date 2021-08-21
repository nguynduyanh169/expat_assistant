import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:flutter/material.dart';

class SpecialistProvider {
  final Dio _dio = Dio();

  Future<dynamic> getSpecialistsByRating(
      {@required String token, @required int page, @required int size}) async {
    List<ListSpec> result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_SPECIALISTS_BY_RATING + "?page=$page&size=$size",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        result = (response.data['listSpec'] as List<dynamic>)
            .map((i) => ListSpec.fromJson(i))
            .toList()
            .cast<ListSpec>();

      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<SpecialistDetails> getSpecialistInfo(
      {@required String token, @required int specId}) async {
    SpecialistDetails result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_SPECIALISTS_INFO + "$specId",
          options: Options(headers: headers));
          print(response.data);
      if (response.statusCode == 200) {
        result = SpecialistDetails.fromJson(response.data);
      }
    } catch (e) {
      print("Error:" + e.toString());
    }
    return result;
  }

  Future<dynamic> getSpecialistByName(
      {@required String token,
      @required int page,
      @required String keyword}) async {
    List<ListSpec> result;
    int size = 6;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_SPECIALISTS_BY_NAME +
              "?fullname=$keyword&page=$page&size=$size",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        result = (response.data['listSpec'] as List<dynamic>)
            .map((i) => ListSpec.fromJson(i))
            .toList()
            .cast<ListSpec>();
        print(result.length);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<dynamic> getSpecialistByMajorId(
      {@required String token,
      @required int page,
      @required int majorId}) async {
    List<ListSpec> result;
    int size = 5;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      print(ApiName.GET_SPECIALISTS_BY_MAJOR +
          "?majorId=$majorId&page=$page&size=$size");
      Response response = await _dio.get(
          ApiName.GET_SPECIALISTS_BY_MAJOR +
              "?majorId=$majorId&page=$page&size=$size",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        result = (response.data['listSpec'] as List<dynamic>)
            .map((i) => ListSpec.fromJson(i))
            .toList()
            .cast<ListSpec>();
        print(result.length);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<dynamic> getSpecialistByCreateDate(
      {@required String token, @required int page}) async {
    List<ListSpec> result;
    int size = 5;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };

      Response response = await _dio.get(
          ApiName.GET_SPECIALISTS_BY_CREATEDATE + "?page=$page&size=$size",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        result = (response.data['listSpec'] as List<dynamic>)
            .map((i) => ListSpec.fromJson(i))
            .toList()
            .cast<ListSpec>();
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
