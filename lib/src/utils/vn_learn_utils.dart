import 'dart:math';

import 'package:expat_assistant/src/models/hive_object.dart';

class VNLearnUtils {
  List<VocabularyLocal> getQuizOption(
      List<VocabularyLocal> vocabularies, VocabularyLocal answer) {
    print(answer.id);
    List<VocabularyLocal> options = [];
    options.add(answer);
    while (options.length < 4) {
      VocabularyLocal vocabularyLocal = getRandomElement(vocabularies);
      if (vocabularyLocal.description != answer.description) {
        options.add(vocabularyLocal);
      }
    }
    options.shuffle();
    return options;
  }

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}
