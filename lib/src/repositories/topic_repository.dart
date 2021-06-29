import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/providers/topic_provider.dart';
import 'package:flutter/foundation.dart';

class TopicRepository{
  final TopicProvider _topicProvider = TopicProvider(); 

  Future<List<Topic>> getAllTopic({@required String token}){
    return _topicProvider.getAllTopic(token: token);
  }

  Future<List<Topic>> getTopicByEventId({@required String token, @required int eventId}){
    return _topicProvider.getTopicsByEventId(token: token, eventId: eventId);
  }
}