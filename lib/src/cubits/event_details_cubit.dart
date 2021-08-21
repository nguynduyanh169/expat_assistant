import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/location.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/repositories/event_repository.dart';
import 'package:expat_assistant/src/repositories/location_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/states/event_details_state.dart';
import 'package:expat_assistant/src/utils/events_utils.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/material.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventRepository _eventRepository;
  LocationRepository _locationRepository;
  TopicRepository _topicRepository;
  final HiveUtils _hiveUtils = HiveUtils();
  EventDetailsCubit(
      this._eventRepository, this._locationRepository, this._topicRepository)
      : super(const EventDetailsState());

  Future<void> getEventContent({@required int eventId}) async {
    emit(state.copyWith(status: EventDetailsStatus.loadingContent));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      EventShow event;
      Content content = await _eventRepository.getEventContentById(
          eventId: eventId, token: token);
      if (content != null) {
        List<Location> locations = await _locationRepository
            .getLocationsByEventId(token: token, eventId: eventId);
        List<Topic> topics = await _topicRepository.getTopicByEventId(
            token: token, eventId: eventId);
        List<Content> contentsExpatId = await _eventRepository
            .getEventByExpatId(token: token, expatId: expatId);
        Content contentExpatId;
        if (contentsExpatId != null) {
          contentExpatId = contentsExpatId.firstWhere(
              (element) => content.eventId == element.eventId,
              orElse: () => null);
        }
        if (contentExpatId == null) {
          event = EventShow(
              location: locations[0],
              topic: topics[0],
              content: content,
              isJoined: false);
        } else {
          event = EventShow(
              location: locations[0],
              topic: topics[0],
              content: content,
              isJoined: true);
        }
        emit(state.copyWith(
            status: EventDetailsStatus.loadedContent, eventContent: event));
      } else {
        emit(state.copyWith(status: EventDetailsStatus.loadContentError));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventDetailsStatus.loadContentError));
    }
  }

  Future<void> joinEvent({@required EventShow event}) async {
    emit(state.copyWith(status: EventDetailsStatus.joiningEvent));
    try {
      bool check = EventUtils.checkJoinEvent(event);
      if (check == false) {
        emit(state.copyWith(status: EventDetailsStatus.preventJoinEvent));
      } else {
        Map<dynamic, dynamic> loginResponse =
            _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
        String token = loginResponse['token'].toString();
        int expatId = loginResponse['id'];
        EventExpat eventExpat = await _eventRepository.joinAnEvent(
            token: token, expatId: expatId, eventId: event.content.eventId);
        if (eventExpat == null) {
          emit(state.copyWith(status: EventDetailsStatus.joinEventFailed));
        } else {
          emit(state.copyWith(status: EventDetailsStatus.joinEventSuccess));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventDetailsStatus.joinEventFailed));
    }
  }

  Future<void> unJoinEvent({@required EventShow event}) async {
    emit(state.copyWith(status: EventDetailsStatus.unjoiningEvent));
    try {
      bool check = EventUtils.checkJoinEvent(event);
      if (check == false) {
        emit(state.copyWith(status: EventDetailsStatus.preventUnjoinEvent));
      } else {
        Map<dynamic, dynamic> loginResponse =
            _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
        String token = loginResponse['token'].toString();
        int expatId = loginResponse['id'];
        int result = await _eventRepository.unjoinAnEvent(
            token: token, expatId: expatId, eventId: event.content.eventId);
        if (result == 0) {
          emit(state.copyWith(status: EventDetailsStatus.unjoinEventFailed));
        } else {
          emit(state.copyWith(status: EventDetailsStatus.unjoinEventSuccess));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventDetailsStatus.unjoinEventFailed));
    }
  }
}
