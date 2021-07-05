import 'dart:async';

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
  loadingJoinedInEvent,
  loadJoinedInEventSuccess,
  loadJoinedInEventFailed,
}

extension Explanation on EventsStatus {
  bool get isInit => this == EventsStatus.init;

  bool get isLoading => this == EventsStatus.loading;

  bool get isLoaded => this == EventsStatus.loaded;

  bool get isLoadError => this == EventsStatus.loadError;

  bool get isCancelChooseType => this == EventsStatus.chooseEventTypeCancel;

  bool get isChooseTypeSuccess => this == EventsStatus.chooseEventTypeSuccess;

  bool get isLoadingJoinedInEvent => this == EventsStatus.loadingJoinedInEvent;

  bool get isLoadJoinedInEventSuccess =>
      this == EventsStatus.loadJoinedInEventSuccess;

  bool get isLoadJoinedInEventFailed =>
      this == EventsStatus.loadJoinedInEventFailed;
}

class EventsState extends Equatable {
  final List<EventShow> events;
  final List<EventShow> oldEvents;
  final bool isFirstFetched;
  final EventsStatus status;
  final int page;
  final Topic chooseTopic;
  final List<Topic> topicList;
  final List<EventShow> joinedEvents;

  const EventsState(
      {this.events,
      this.isFirstFetched,
      this.oldEvents,
      this.status,
      this.page,
      this.chooseTopic,
      this.topicList,
      this.joinedEvents});

  @override
  List<Object> get props => [
        events,
        isFirstFetched,
        oldEvents,
        status,
        page,
        chooseTopic,
        topicList,
        joinedEvents
      ];

  EventsState copyWith(
      {List<EventShow> events,
      bool isFirstFetched,
      List<EventShow> oldEvents,
      EventsStatus status,
      int page,
      Topic chooseTopic,
      List<Topic> topicList,
      List<EventShow> joinedEvents}) {
    return EventsState(
        events: events ?? this.events,
        isFirstFetched: isFirstFetched ?? this.isFirstFetched,
        status: status ?? this.status,
        oldEvents: oldEvents ?? this.oldEvents,
        page: page ?? this.page,
        chooseTopic: chooseTopic ?? this.chooseTopic,
        topicList: topicList ?? this.topicList,
        joinedEvents: joinedEvents ?? this.joinedEvents);
  }
}
