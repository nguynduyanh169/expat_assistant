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
      List<Location> locations = await _locationRepository
          .getLocationsByEventId(token: token, eventId: eventId);
      List<Topic> topics = await _topicRepository.getTopicByEventId(
          token: token, eventId: eventId);
      Content content = await _eventRepository.getEventContentById(
          eventId: eventId, token: token);
      if (content != null) {
        event = new EventShow(
            content: content, location: locations[0], topic: topics[0]);
        emit(state.copyWith(status: EventDetailsStatus.loadedContent, eventContent: event));
      }else{
        emit(state.copyWith(status: EventDetailsStatus.loadContentError));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventDetailsStatus.loadContentError));
    }
  }
}
