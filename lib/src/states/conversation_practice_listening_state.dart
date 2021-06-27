import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/character_description.dart';

enum ConversationPracticeListeningStatus {
  init,
  loaded,
  loadError,
  addCharacter,
  correctAnswer,
  incorrectAnswer,
}

extension Explanation on ConversationPracticeListeningStatus {
  bool get isInit => this == ConversationPracticeListeningStatus.init;

  bool get isLoaded => this == ConversationPracticeListeningStatus.loaded;

  bool get isLoadError => this == ConversationPracticeListeningStatus.loadError;

  bool get isAddCharacter =>
      this == ConversationPracticeListeningStatus.addCharacter;

  bool get isCorrect =>
      this == ConversationPracticeListeningStatus.correctAnswer;

  bool get isIncorrect =>
      this == ConversationPracticeListeningStatus.incorrectAnswer;
}

class ConversationPracticeListeningState extends Equatable {
  final String error;
  final CharacterDescription word;
  final List<String> words;
  final ConversationPracticeListeningStatus status;

  const ConversationPracticeListeningState(
      {this.word, this.words, this.error, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [error, word, words, status];

  ConversationPracticeListeningState copyWith(
      {String error,
      CharacterDescription word,
      List<String> words,
      ConversationPracticeListeningStatus status}) {
    return ConversationPracticeListeningState(
        error: error ?? this.error,
        word: word ?? this.word,
        words: words ?? this.words,
        status: status ?? status);
  }
}
