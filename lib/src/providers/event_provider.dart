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
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<Content> getEventContentById(
      {@required int eventId, @required String token}) async {
    Content result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_EVENT_CONTENT_BY_ID + eventId.toString(),
          options: Options(headers: headers));
      result = Content.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<Content>> searchEventByTitle(
      {@required String keyWord, @required String token}) async {
    List<Content> result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_EVENTS_BY_TITLE + "?title=$keyWord",
          options: Options(headers: headers));
      result = (response.data as List<dynamic>)
          .map((i) => Content.fromJson(i))
          .toList()
          .cast<Content>();
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<Content>> getEventByExpatId(
      {@required String token, @required int expatId}) async {
    List<Content> result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_EVENTS_BY_EXPATID + "?expatId=$expatId",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        result = (response.data as List<dynamic>)
            .map((i) => Content.fromJson(i))
            .toList()
            .cast<Content>();
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<EventExpat> joinAnEvent(
      {@required String token,
      @required int expatId,
      @required int eventId}) async {
    EventExpat result;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.post(
          ApiName.JOIN_EVENT + "?eventId=$eventId&expatId=$expatId",
          options: Options(headers: headers));
      result = EventExpat.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> unjoinAnEvent(
      {@required String token,
      @required int expatId,
      @required int eventId}) async {
    int result = 0;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.put(
          ApiName.UNJOIN_EVENT + "?eventId=$eventId&expatId=$expatId",
          options: Options(headers: headers));
      result = response.data;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
