import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/models/event_details.dart';
import 'package:expat_assistant/src/providers/event_provider.dart';
import 'package:flutter/cupertino.dart';

class EventRepository {
  final EventProvider _eventProvider = EventProvider();

  Future<Event> getEventsPagination(
      {@required int page, @required String token}) {
    return _eventProvider.getEventsPagingation(page: page, token: token);
  }

  Future<EventDetails> getEventContentById(
      {@required int eventId, @required String token}) {
    return _eventProvider.getEventContentById(eventId: eventId, token: token);
  }

  Future<List<Content>> searchEventByTitle(
      {@required String keyWord, @required String token}) {
    return _eventProvider.searchEventByTitle(keyWord: keyWord, token: token);
  }

  Future<List<Content>> getEventByExpatId(
      {@required String token, @required int expatId}) {
    return _eventProvider.getEventByExpatId(token: token, expatId: expatId);
  }

  Future<EventExpat> joinAnEvent(
      {@required String token, @required int expatId, @required int eventId}) {
    return _eventProvider.joinAnEvent(
        token: token, expatId: expatId, eventId: eventId);
  }

  Future<int> unjoinAnEvent(
      {@required String token, @required int expatId, @required int eventId}) {
    return _eventProvider.unjoinAnEvent(
        token: token, expatId: expatId, eventId: eventId);
  }

  Future<dynamic> findEventsByStatus(
      {@required String token, @required String status}) {
    return _eventProvider.findEventsByStatus(token: token, status: status);
  }

  Future<dynamic> getEventsByTopicId({@required int topicId}) {
    return _eventProvider.getEventsByTopicId(topicId: topicId);
  }
}
