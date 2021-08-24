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
      int expatId = loginResponse['id'];
      if (state.status.isLoading) return null;
      final currentState = state;
      Event eventJson;
      List<EventShow> oldEvents = [];
      List<Content> contents = [];
      List<Content> contentsExpatId = [];
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
        topicList = await _topicRepository.getAllTopic(token: token);
      }
      page++;
      final events = state.oldEvents;
      contents.addAll(eventJson.content);
      for (Content content in contents) {
        locations = await _locationRepository.getLocationsByEventId(
            token: token, eventId: content.eventId);
        topics = await _topicRepository.getTopicByEventId(
            token: token, eventId: content.eventId);
        contentsExpatId = await _eventRepository.getEventByExpatId(
            token: token, expatId: expatId);
        Content contentExpatId;
        if (contentsExpatId != null) {
          contentExpatId = contentsExpatId.firstWhere(
              (element) => content.eventId == element.eventId,
              orElse: () => null);
        }
        if (contentExpatId == null) {
          print(content.eventId);
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
        events.add(event);
      }
      emit(state.copyWith(
          status: EventsStatus.loaded,
          events: events,
          page: page,
          topicList: topicList));
    } on Exception {
      emit(state.copyWith(status: EventsStatus.loadError));
    }
  }

  Future<void> pressCategory(int topicId) async {
    emit(state.copyWith(status: EventsStatus.loadingEventTopic));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      List<Content> contentsTopic = [];
      List<Location> locations = [];
      List<Topic> topics = [];
      List<EventShow> events = [];
      contentsTopic =
          await _eventRepository.getEventsByTopicId(topicId: topicId);
      if (contentsTopic == null || contentsTopic.isEmpty) {
        emit(state.copyWith(status: EventsStatus.loadEventTopicFailed));
      } else {
        for (Content content in contentsTopic) {
          locations = await _locationRepository.getLocationsByEventId(
              token: token, eventId: content.eventId);
          topics = await _topicRepository.getTopicByEventId(
              token: token, eventId: content.eventId);
          EventShow event = EventShow(
              content: content,
              topic: topics[0],
              location: locations[0],
              isJoined: true);
          events.add(event);
        }
        emit(state.copyWith(
            status: EventsStatus.loadEventTopicSuccess, eventsByTopic: events));
      }
    } catch (e) {
      emit(state.copyWith(status: EventsStatus.loadEventTopicFailed));
    }
  }

  Future<void> pressJoinedIn() async {
    emit(state.copyWith(status: EventsStatus.loadingJoinedInEvent));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      List<Content> contentsExpatId = [];
      List<Location> locations = [];
      List<Topic> topics = [];
      List<EventShow> events = [];
      contentsExpatId = await _eventRepository.getEventByExpatId(
          token: token, expatId: expatId);
      if (contentsExpatId == null || contentsExpatId.isEmpty) {
        emit(state.copyWith(status: EventsStatus.loadJoinedInEventFailed));
      } else {
        for (Content content in contentsExpatId) {
          locations = await _locationRepository.getLocationsByEventId(
              token: token, eventId: content.eventId);
          topics = await _topicRepository.getTopicByEventId(
              token: token, eventId: content.eventId);
          EventShow event = EventShow(
              content: content,
              topic: topics[0],
              location: locations[0],
              isJoined: true);
          events.add(event);
        }
        emit(state.copyWith(
            status: EventsStatus.loadJoinedInEventSuccess,
            joinedEvents: events));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventsStatus.loadJoinedInEventFailed));
    }
  }

  Future<void> pressStatus(String status) async {
    emit(state.copyWith(status: EventsStatus.loadingEventByStatus));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      List<Content> contentsStatus = [];
      List<Location> locations = [];
      List<Topic> topics = [];
      List<EventShow> events = [];
      contentsStatus = await _eventRepository.findEventsByStatus(
          token: token, status: status);
      if (contentsStatus == null || contentsStatus.isEmpty) {
        emit(state.copyWith(status: EventsStatus.loadEventByStatusFailed));
      } else {
        for (Content content in contentsStatus) {
          locations = await _locationRepository.getLocationsByEventId(
              token: token, eventId: content.eventId);
          topics = await _topicRepository.getTopicByEventId(
              token: token, eventId: content.eventId);
          EventShow event = EventShow(
              content: content,
              topic: topics[0],
              location: locations[0],
              isJoined: true);
          events.add(event);
        }
        emit(state.copyWith(
            status: EventsStatus.loadEventByStatusSuccess,
            eventsByStatus: events));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: EventsStatus.loadEventByStatusFailed));
    }
  }
}
