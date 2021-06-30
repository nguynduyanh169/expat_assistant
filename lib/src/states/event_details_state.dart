import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/event.dart';

enum EventDetailsStatus {
  loadingContent,
  loadedContent,
  loadContentError,
}

extension Explanation on EventDetailsStatus {
  bool get isLoadingContent => this == EventDetailsStatus.loadingContent;

  bool get isLoadedContent => this == EventDetailsStatus.loadedContent;

  bool get isLoadError => this == EventDetailsStatus.loadContentError;
}

class EventDetailsState extends Equatable {
  final EventShow eventContent;
  final String message;
  final EventDetailsStatus status;

  const EventDetailsState({this.eventContent, this.message, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [eventContent, message, status];

  EventDetailsState copyWith(
      {EventShow eventContent, String message, EventDetailsStatus status}) {
    return EventDetailsState(
        eventContent: eventContent ?? this.eventContent,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}
