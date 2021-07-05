import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:flutter/material.dart';

class BlogProvider {
  final Dio _dio = Dio();

  Future<dynamic> getBlogsByPriority(
      {@required String token,
      @required int page,
      @required int priority}) async {
    Blog blog;
    int size = 3;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_BLOGS_BY_PRIORITY +
              "?page=$page&priority=$priority&size=$size&sortBy=createDate",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        blog = Blog.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return blog;
  }

  Future<dynamic> getBlogs(
      {@required String token,
      @required int page,
      @required int priority}) async {
    Blog blog;
    int size = 3;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_BLOGS + "?page=$page&size=$size&sortBy=createDate",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        blog = Blog.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return blog;
  }
}
