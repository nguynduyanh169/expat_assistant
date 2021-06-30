import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/location.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/repositories/event_repository.dart';
import 'package:expat_assistant/src/repositories/location_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/states/search_event_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class SearchEventCubit extends Cubit<SearchEventState> {
  EventRepository _eventRepository;
  LocationRepository _locationRepository;
  TopicRepository _topicRepository;
  HiveUtils _hiveUtils = HiveUtils();
  SearchEventCubit(
      this._eventRepository, this._locationRepository, this._topicRepository)
      : super(const SearchEventState(status: SearchEventStatus.init));

  Future<void> searchEvents(String searchKeyWord) async {
    searchKeyWord = 'Launch Wine Flights Event';
    emit(state.copyWith(status: SearchEventStatus.searching));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      List<Content> contentList = await _eventRepository.searchEventByTitle(
          keyWord: searchKeyWord, token: token);
      print(contentList.length);
      List<EventShow> events = [];
      for (Content content in contentList) {
        List<Location> locations = await _locationRepository
            .getLocationsByEventId(token: token, eventId: content.eventId);
        List<Topic> topics = await _topicRepository.getTopicByEventId(
            token: token, eventId: content.eventId);
        EventShow event = EventShow(
            location: locations[0], topic: topics[0], content: content);
        events.add(event);
      }
      emit(state.copyWith(
          searchEventList: events, status: SearchEventStatus.searchSuccess));
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
          hasError: true,
          status: SearchEventStatus.searchError,
          message: e.toString()));
    }
  }
}
