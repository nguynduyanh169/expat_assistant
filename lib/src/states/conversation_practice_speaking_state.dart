import 'package:equatable/equatable.dart';

enum ConversationPracticeSpeakingStatus {
  init,
}

extension Explanation on ConversationPracticeSpeakingStatus {
  bool get isInit => this == ConversationPracticeSpeakingStatus.init;
}

class ConversationPracticeSpeakingState extends Equatable {
  final ConversationPracticeSpeakingStatus status;

  const ConversationPracticeSpeakingState({this.status});

  @override
  // TODO: implement props
  List<Object> get props => [status];

  ConversationPracticeSpeakingState copyWith(
      {ConversationPracticeSpeakingStatus status}) {
    return ConversationPracticeSpeakingState(status: status ?? this.status);
  }
}
