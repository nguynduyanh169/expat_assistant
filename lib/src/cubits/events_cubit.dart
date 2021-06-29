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
      EventShow event;
      if (currentState.status.isLoaded) {
        oldEvents = currentState.events;
      }
      emit(state.copyWith(
          status: EventsStatus.loading,
          oldEvents: oldEvents,
          isFirstFetched: page == 0));
      eventJson =
          await _eventRepository.getEventsPagination(page: page, token: token);
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
          status: EventsStatus.loaded, events: events, page: page));
      // _eventRepository
      //     .getEventsPagination(page: page, token: token)
      //     .then((value) {
      //   page++;
      //   final events = state.oldEvents;
      //   for (Content content in value.content) {
      //     EventShow event = EventShow(content: content);
      //     _locationRepository
      //         .getLocationsByEventId(token: token, eventId: content.eventId)
      //         .then((value) {
      //       event.location = value[0];
      //       print(event.location.locationName);
      //     });
      //     _topicRepository
      //         .getTopicByEventId(token: token, eventId: content.eventId)
      //         .then((value) => event.topic = value[0]);
      //     events.add(event);
      //     print('done');
      //   }
      //   emit(state.copyWith(
      //       status: EventsStatus.loaded, events: events, page: page));
      // });

    } on Exception {
      emit(state.copyWith(status: EventsStatus.loadError));
    }
  }
}
