import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/vocabulary.dart';
import 'package:flutter/cupertino.dart';

class VocabularyProvider {
  final Dio _dio = Dio();

  Future<List<Vocabulary>> getVocabulariesByLessonId({@required String lessonId, @required String token}) async{
    List<Vocabulary> result;
    try{
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token'
      };
      Response response = await _dio.get(ApiName.FIND_CONVERSATION_BY_TOPIC_ID + "/$lessonId", options: Options(headers: headers));
      result = (response.data as List<dynamic>)
          .map((i) => Vocabulary.fromJson(i))
          .toList()
          .cast<Vocabulary>();
    }catch (e){
      print(e.toString());
    }
    return result;
  }
}
