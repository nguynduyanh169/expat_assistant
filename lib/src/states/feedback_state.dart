import 'package:equatable/equatable.dart';

class FeedbackState extends Equatable {
  final String message;
  final FeedbackStatus status;

  const FeedbackState({this.message, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [status, message];

  FeedbackState copyWith({String message, FeedbackStatus status}) {
    return FeedbackState(
        message: message ?? this.message, status: status ?? this.status);
  }
}

enum FeedbackStatus {
  init,
  feedbacking,
  feedbackCompleted,
  feedBackError,
  loading,
  loaded,
  loadError
}

extension Explaination on FeedbackStatus {
  bool get isInit => this == FeedbackStatus.init;
  bool get isLoading => this == FeedbackStatus.loading;
  bool get isLoaded => this == FeedbackStatus.loaded;
  bool get isLoadError => this == FeedbackStatus.loadError;
  bool get isFeedbacking => this == FeedbackStatus.feedbacking;
  bool get isFeedbackCompleted => this == FeedbackStatus.feedbackCompleted;
  bool get isFeedbackError => this == FeedbackStatus.feedBackError;
}
