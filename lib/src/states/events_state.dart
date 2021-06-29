import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/event.dart';

enum EventsStatus { init, loading, loaded, loadError }

extension Explanation on EventsStatus{
  bool get isInit => this == EventsStatus.init;

  bool get isLoading => this == EventsStatus.loading;

  bool get isLoaded => this == EventsStatus.loaded;

  bool get isLoadError => this == EventsStatus.loadError;
}

class EventsState extends Equatable {
  final List<EventShow> events;
  final List<EventShow> oldEvents;
  final bool isFirstFetched;
  final EventsStatus status;
  final int page;

  const EventsState({this.events, this.isFirstFetched, this.oldEvents, this.status, this.page});

  @override
  // TODO: implement props
  List<Object> get props => [events, isFirstFetched, oldEvents, status, page];

  EventsState copyWith(
      {List<EventShow> events,
      bool isFirstFetched,
      List<EventShow> oldEvents,
      EventsStatus status, int page}) {
    return EventsState(
        events: events ?? this.events,
        isFirstFetched: isFirstFetched ?? this.isFirstFetched,
        status: status ?? this.status,
        oldEvents: oldEvents ?? this.oldEvents, page: page ?? this.page);
  }
}
