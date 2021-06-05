import 'package:expat_assistant/src/models/character_description.dart';

abstract class VocabularyPracticeListeningState{
  const VocabularyPracticeListeningState();
}

class Init extends VocabularyPracticeListeningState{
  const Init();
}

class Loaded extends VocabularyPracticeListeningState{
  final chars;
  const Loaded(this.chars);
}

class LoadError extends VocabularyPracticeListeningState{
  const LoadError();
}

class AddCharacter extends VocabularyPracticeListeningState{
  final CharacterDescription char;
  const AddCharacter(this.char);
}

class CorrectAnswer extends VocabularyPracticeListeningState{
  const CorrectAnswer();
}

class IncorrectAnswer extends VocabularyPracticeListeningState{
  const IncorrectAnswer();
}

class PlayAudio extends VocabularyPracticeListeningState{
  const PlayAudio();
}

class StoppedAudio extends VocabularyPracticeListeningState{
  const StoppedAudio();
}