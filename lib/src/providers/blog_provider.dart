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

  Future<dynamic> getBlogs({@required String token, @required int page}) async {
    List<ListBlog> blogs;
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
        blogs = (response.data['content'] as List<dynamic>)
            .map((i) => ListBlog.fromJson(i))
            .toList()
            .cast<ListBlog>();
      }
    } catch (e) {
      print(e.toString());
    }
    return blogs;
  }

  Future<dynamic> getBlogsByChannel(
      {@required String token,
      @required int page,
      @required int channelId}) async {
    List<ListBlog> blogs;
    int size = 3;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_BLOGS_BY_CHANNEL +
              "?channelId=$channelId&page=$page&size=$size&sortBy=blogId",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        blogs = (response.data['listBlog'] as List<dynamic>)
            .map((i) => ListBlog.fromJson(i))
            .toList()
            .cast<ListBlog>();
      }
    } catch (e) {
      print(e.toString());
    }
    return blogs;
  }

  Future<dynamic> getBlogsByTitle(
      {@required String token,
      @required int page,
      @required String keywords}) async {
    List<ListBlog> blogs;
    int size = 3;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_BLOGS_BY_TITLE +
              "?page=$page&size=$size&sortBy=blogId&title=$keywords",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        blogs = (response.data['listBlog'] as List<dynamic>)
            .map((i) => ListBlog.fromJson(i))
            .toList()
            .cast<ListBlog>();
      }
    } catch (e) {
      print(e.toString());
    }
    return blogs;
  }

  Future<ListBlog> getBlogInfoById(
      {@required String token, @required int blogId}) async {
    ListBlog blog;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_BLOGS_BY_ID + blogId.toString(),
          options: Options(headers: headers));
      blog = ListBlog.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return blog;
  }

  Future<dynamic> getBlogsByCategory(
      {@required String token,
      @required int page,
      @required int categoryId}) async {
    List<ListBlog> blogs;
    int size = 4;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_BLOGS_BY_CATEGORYID +
              "?categoryId=$categoryId&page=$page&size=$size&sortBy=blogId",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        blogs = (response.data['listBlog'] as List<dynamic>)
            .map((i) => ListBlog.fromJson(i))
            .toList()
            .cast<ListBlog>();
      }
    } catch (e) {
      print(e.toString());
    }
    return blogs;
  }

  Future<dynamic> getBlogsByDate(
      {@required String token,
      @required String date,
      @required int page}) async {
    List<ListBlog> blogs;
    int size = 3;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_BLOGS_BY_DATE +
              "?createDate=$date&page=$page&size=$size&sortBy=blogId",
          options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 204) {
        return 204;
      } else {
        blogs = (response.data['listBlog'] as List<dynamic>)
            .map((i) => ListBlog.fromJson(i))
            .toList()
            .cast<ListBlog>();
      }
    } catch (e) {
      print(e.toString());
    }
    return blogs;
  }
}
