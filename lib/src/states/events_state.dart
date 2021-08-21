import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/topic.dart';

enum EventsStatus {
  init,
  loading,
  loaded,
  loadError,
  loadEventTopicSuccess,
  loadingEventTopic,
  loadEventTopicFailed,
  loadEventTopicEmpty,
  loadingJoinedInEvent,
  loadJoinedInEventSuccess,
  loadJoinedInEventFailed,
  loadingEventByStatus,
  loadEventByStatusSuccess,
  loadEventByStatusFailed,
  loadEventByStatusEmpty,
}

extension Explanation on EventsStatus {
  bool get isInit => this == EventsStatus.init;

  bool get isLoading => this == EventsStatus.loading;

  bool get isLoaded => this == EventsStatus.loaded;

  bool get isLoadError => this == EventsStatus.loadError;

  bool get isLoadingEventTopic => this == EventsStatus.loadingEventTopic;

  bool get isLoadedEventTopic => this == EventsStatus.loadEventTopicSuccess;

  bool get isLoadEventTopicFailed => this == EventsStatus.loadEventTopicFailed;

  bool get isLoadEventTopicEmpty => this == EventsStatus.loadEventTopicEmpty;

  bool get isLoadingJoinedInEvent => this == EventsStatus.loadingJoinedInEvent;

  bool get isLoadJoinedInEventSuccess =>
      this == EventsStatus.loadJoinedInEventSuccess;

  bool get isLoadJoinedInEventFailed =>
      this == EventsStatus.loadJoinedInEventFailed;

  bool get isLoadingEventByStatus => this == EventsStatus.loadingEventByStatus;

  bool get isLoadEventByStatusSuccess =>
      this == EventsStatus.loadEventByStatusSuccess;

  bool get isLoadEventByStatusFailed =>
      this == EventsStatus.loadEventByStatusFailed;

  bool get isLoadEventByStatusEmpty =>
      this == EventsStatus.loadEventByStatusEmpty;
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
  final List<EventShow> eventsByStatus;
  final List<EventShow> eventsByTopic;

  const EventsState(
      {this.events,
      this.isFirstFetched,
      this.oldEvents,
      this.status,
      this.page,
      this.chooseTopic,
      this.topicList,
      this.joinedEvents,
      this.eventsByStatus,
      this.eventsByTopic});

  @override
  List<Object> get props => [
        events,
        isFirstFetched,
        oldEvents,
        status,
        page,
        chooseTopic,
        topicList,
        joinedEvents,
        eventsByStatus,
        eventsByTopic
      ];

  EventsState copyWith(
      {List<EventShow> events,
      bool isFirstFetched,
      List<EventShow> oldEvents,
      EventsStatus status,
      int page,
      Topic chooseTopic,
      List<Topic> topicList,
      List<EventShow> joinedEvents,
      List<EventShow> eventsByStatus,
      List<EventShow> eventsByTopic}) {
    return EventsState(
        events: events ?? this.events,
        isFirstFetched: isFirstFetched ?? this.isFirstFetched,
        status: status ?? this.status,
        oldEvents: oldEvents ?? this.oldEvents,
        page: page ?? this.page,
        chooseTopic: chooseTopic ?? this.chooseTopic,
        topicList: topicList ?? this.topicList,
        joinedEvents: joinedEvents ?? this.joinedEvents,
        eventsByStatus: eventsByStatus ?? this.eventsByStatus,
        eventsByTopic: eventsByTopic ?? this.eventsByTopic);
  }
}
