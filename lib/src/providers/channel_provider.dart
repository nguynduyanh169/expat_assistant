import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:flutter/material.dart';

class ChannelProvider {
  final Dio _dio = Dio();

  Future<dynamic> getChannelsPaging(
      {@required String token, @required int page}) async {
    List<Channel> channels;
    int size = 4;
    int status = 1;
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token',
      };
      Response response = await _dio.get(
          ApiName.GET_CHANNELS_STATUS +
              "?page=$page&size=$size&sortBy=channelId&status=$status",
          options: Options(headers: headers));
      if (response.statusCode == 204) {
        return 204;
      } else {
        channels = (response.data['listChannel'] as List<dynamic>)
            .map((i) => Channel.fromJson(i))
            .toList()
            .cast<Channel>();
      }
    } catch (e) {
      print(e.toString());
    }
    return channels;
  }
}
