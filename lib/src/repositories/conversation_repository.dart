import 'package:expat_assistant/src/models/conversation.dart';
import 'package:expat_assistant/src/providers/conversation_provider.dart';
import 'package:flutter/cupertino.dart';

class ConversationRepository{
  final ConversationProvider _conversationProvider = ConversationProvider();

  Future<List<Conversation>> findConversationsByLessonId({@required int topicId, @required String token}){
    return _conversationProvider.findConversationsByLessonId(topicId: topicId, token: token);
  }
}