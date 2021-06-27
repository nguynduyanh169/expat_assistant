import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/character_description.dart';
import 'package:expat_assistant/src/states/conversation_practice_listening_state.dart';

class ConversationPracticeListeningCubit
    extends Cubit<ConversationPracticeListeningState> {
  ConversationPracticeListeningCubit()
      : super(const ConversationPracticeListeningState());

  Future<void> loadCharacters(String vietnameseSentence) async {
    try {
      var matches = vietnameseSentence.split(" ");
      matches.shuffle();
      List<String> words = [];
      for (var m in matches) {
        words.add(m);
      }
      emit(state.copyWith(
          words: words, status: ConversationPracticeListeningStatus.loaded));
    } on Exception catch (e) {
      emit(state.copyWith(
          error: e.toString(),
          status: ConversationPracticeListeningStatus.loadError));
    }
  }

  Future<void> checkAnswer(String learnerAns, String vietnamese) async {
    if (learnerAns.trim().toUpperCase() == vietnamese.trim().toUpperCase()) {
      emit(state.copyWith(
          status: ConversationPracticeListeningStatus.correctAnswer));
    } else {
      emit(state.copyWith(
          status: ConversationPracticeListeningStatus.incorrectAnswer));
    }
  }

  Future<void> addCharacters(CharacterDescription character) async {
    emit(state.copyWith(
        status: ConversationPracticeListeningStatus.addCharacter,
        word: character));
  }
}
