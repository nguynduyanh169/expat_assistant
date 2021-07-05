import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/location.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/repositories/event_repository.dart';
import 'package:expat_assistant/src/repositories/location_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/states/event_details_state.dart';
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
      EventShow event;
      Content content = await _eventRepository.getEventContentById(
          eventId: eventId, token: token);
      if (content != null) {
        List<Location> locations = await _locationRepository
            .getLocationsByEventId(token: token, eventId: eventId);
        List<Topic> topics = await _topicRepository.getTopicByEventId(
            token: token, eventId: eventId);
        List<Content> contentsExpatId =
            await _eventRepository.getEventByExpatId(token: token, expatId: 6);
        Content contentExpatId = contentsExpatId.firstWhere(
            (element) => content.eventId == element.eventId,
            orElse: () => null);
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

  Future<void> joinEvent({@required int eventId, @required int expatId}) async {
    emit(state.copyWith(status: EventDetailsStatus.joiningEvent));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      EventExpat eventExpat = await _eventRepository.joinAnEvent(
          token: token, expatId: expatId, eventId: eventId);
      if (eventExpat == null) {
        emit(state.copyWith(status: EventDetailsStatus.joinEventFailed));
      } else {
        emit(state.copyWith(status: EventDetailsStatus.joinEventSuccess));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventDetailsStatus.joinEventFailed));
    }
  }

  Future<void> unJoinEvent(
      {@required int eventId, @required int expatId}) async {
    emit(state.copyWith(status: EventDetailsStatus.unjoiningEvent));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int result = await _eventRepository.unjoinAnEvent(
          token: token, expatId: expatId, eventId: eventId);
      if (result == 0) {
        emit(state.copyWith(status: EventDetailsStatus.unjoinEventFailed));
      } else {
        emit(state.copyWith(status: EventDetailsStatus.unjoinEventSuccess));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventDetailsStatus.unjoinEventFailed));
    }
  }
}
