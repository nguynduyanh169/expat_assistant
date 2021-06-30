import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/location.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/repositories/event_repository.dart';
import 'package:expat_assistant/src/repositories/location_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/states/events_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/widgets/alert_dialog_vocabulary.dart';
import 'package:flutter/material.dart';

class EventsCubit extends Cubit<EventsState> {
  EventRepository _eventRepository;
  LocationRepository _locationRepository;
  TopicRepository _topicRepository;
  final HiveUtils _hiveUtils = HiveUtils();
  EventsCubit(
      this._eventRepository, this._locationRepository, this._topicRepository)
      : super(const EventsState(status: EventsStatus.init));

  Future<void> loadEvents(int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoading) return null;
      final currentState = state;
      Event eventJson;
      List<EventShow> oldEvents = [];
      List<Content> contents = [];
      List<Location> locations = [];
      List<Topic> topics = [];
      List<Topic> topicList = [];
      EventShow event;
      if (currentState.status.isLoaded) {
        oldEvents = currentState.events;
      }
      emit(state.copyWith(
        status: EventsStatus.loading,
        oldEvents: oldEvents,
        isFirstFetched: page == 0,
      ));
      eventJson =
          await _eventRepository.getEventsPagination(page: page, token: token);
      if (page == 0) {
        topicList =
            await _topicRepository.getAllTopic(token: token);
      }
      page++;
      final events = state.oldEvents;
      contents.addAll(eventJson.content);
      for (Content content in contents) {
        locations = await _locationRepository.getLocationsByEventId(
            token: token, eventId: content.eventId);
        topics = await _topicRepository.getTopicByEventId(
            token: token, eventId: content.eventId);
        event = EventShow(
            location: locations[0], topic: topics[0], content: content);
        events.add(event);
      }
      emit(state.copyWith(
          status: EventsStatus.loaded, events: events, page: page, topicList: topicList));
    } on Exception {
      emit(state.copyWith(status: EventsStatus.loadError));
    }
  }

  Future<void> chooseTopic(BuildContext context, List<Topic> topics) async {
    Map<dynamic, dynamic> loginResponse =
        _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
    String token = loginResponse['token'].toString();
    Topic seletedTopic;
    if (topics.length == 0 || topics != null) {
      showConfimationDialogForCategory(
              context: context, action: () {}, topics: topics)
          .then((value) {
        seletedTopic = value;
        print(seletedTopic.topicDesc);
      });
    }
  }
}