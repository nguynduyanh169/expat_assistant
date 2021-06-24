import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/conversation.dart';
import 'package:flutter/cupertino.dart';

class ConversationProvider{
  final Dio _dio = Dio();

  Future<List<Conversation>> findConversationsByLessonId({@required int topicId, @required String token}) async{
    List<Conversation> conversations;
    try{
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token'
      };
      Response response = await _dio.get(ApiName.FIND_CONVERSATION_BY_TOPIC_ID + "/$topicId", options: Options(headers: headers));
      conversations = (response.data as List<dynamic>)
          .map((i) => Conversation.fromJson(i))
          .toList()
          .cast<Conversation>();
    }catch (e){
      print(e.toString());
    }
    return conversations;
  }
}