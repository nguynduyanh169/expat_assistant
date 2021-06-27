import 'package:equatable/equatable.dart';

enum PracticeConversationStatus {
  practiceListening,
  practiceSpeaking,
  practiceDone
}

extension Explanation on PracticeConversationStatus{

  bool get isPracticeListening => this == PracticeConversationStatus.practiceListening;

  bool get isPracticeSpeaking => this == PracticeConversationStatus.practiceSpeaking;

  bool get isPracticeDone => this == PracticeConversationStatus.practiceDone;
}

class PracticeConversationState extends Equatable {
  final PracticeConversationStatus status;
  final int index;
  final int lessonLenght;
  final String error;

  const PracticeConversationState(
      {this.status, this.index, this.error, this.lessonLenght});

  @override
  List<Object> get props => [status, index, lessonLenght, error];

  PracticeConversationState copyWith(
      {PracticeConversationStatus status,
      int index,
      String error,
      int lessonLenght}) {
    return PracticeConversationState(
        status: status ?? this.status,
        index: index ?? this.index,
        error: error ?? this.error,
        lessonLenght: lessonLenght ?? this.lessonLenght);
  }
}
