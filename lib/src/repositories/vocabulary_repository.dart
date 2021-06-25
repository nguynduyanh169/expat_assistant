import 'package:expat_assistant/src/models/vocabulary.dart';
import 'package:expat_assistant/src/providers/vocabulary_provider.dart';
import 'package:flutter/cupertino.dart';

class VocabularyRepository {
  final VocabularyProvider _vocabularyProvider = VocabularyProvider();

  Future<List<Vocabulary>> getVocabulariesByLessonId({@required int lessonId, @required String token}){
    return _vocabularyProvider.getVocabulariesByLessonId(lessonId: lessonId, token: token);
  }
}
