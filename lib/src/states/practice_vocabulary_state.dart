import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
enum PracticeVocabularyStatus{
  practiceWriting, practiceListening, practiceSpeaking, practiceDone
}

extension Explanation on PracticeVocabularyStatus{
  bool get isPracticeWriting => this == PracticeVocabularyStatus.practiceWriting;

  bool get isPracticeListening => this == PracticeVocabularyStatus.practiceListening;

  bool get isPracticeSpeaking => this == PracticeVocabularyStatus.practiceSpeaking;

  bool get isPracticeDone => this == PracticeVocabularyStatus.practiceDone;
}

class PracticeVocabularyState extends Equatable{
  final PracticeVocabularyStatus status;
  final int index;
  final int lessonLenght;
  final String error;

  const PracticeVocabularyState({ this.status, this.index, this.error, this.lessonLenght});

  @override
  // TODO: implement props
  List<Object> get props => [index, status];

  PracticeVocabularyState copyWith({PracticeVocabularyStatus status, int index, String error, int lessonLenght}){
    return PracticeVocabularyState(status: status ?? this.status, index: index ?? this.index, error: error ?? this.error, lessonLenght: lessonLenght ?? this.lessonLenght);
  }

}

