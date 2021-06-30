import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/topic.dart';

enum EventsStatus {
  init,
  loading,
  loaded,
  loadError,
  chooseEventTypeCancel,
  chooseEventTypeSuccess,
}

extension Explanation on EventsStatus {
  bool get isInit => this == EventsStatus.init;

  bool get isLoading => this == EventsStatus.loading;

  bool get isLoaded => this == EventsStatus.loaded;

  bool get isLoadError => this == EventsStatus.loadError;

  bool get isCancelChooseType => this == EventsStatus.chooseEventTypeCancel;

  bool get isChooseTypeSuccess => this == EventsStatus.chooseEventTypeSuccess;
}

class EventsState extends Equatable {
  final List<EventShow> events;
  final List<EventShow> oldEvents;
  final bool isFirstFetched;
  final EventsStatus status;
  final int page;
  final Topic chooseTopic;
  final List<Topic> topicList;

  const EventsState(
      {this.events,
      this.isFirstFetched,
      this.oldEvents,
      this.status,
      this.page,
      this.chooseTopic,
      this.topicList});

  @override
  List<Object> get props =>
      [events, isFirstFetched, oldEvents, status, page, chooseTopic, topicList];

  EventsState copyWith(
      {List<EventShow> events,
      bool isFirstFetched,
      List<EventShow> oldEvents,
      EventsStatus status,
      int page,
      Topic chooseTopic,
      List<Topic> topicList}) {
    return EventsState(
        events: events ?? this.events,
        isFirstFetched: isFirstFetched ?? this.isFirstFetched,
        status: status ?? this.status,
        oldEvents: oldEvents ?? this.oldEvents,
        page: page ?? this.page,
        chooseTopic: chooseTopic ?? this.chooseTopic,
        topicList: topicList ?? this.topicList);
  }
}
