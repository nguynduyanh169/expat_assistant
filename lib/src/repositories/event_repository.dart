import 'package:expat_assistant/src/models/event.dart';
import 'package:expat_assistant/src/providers/event_provider.dart';
import 'package:flutter/cupertino.dart';

class EventRepository {
  final EventProvider _eventProvider = EventProvider();

  Future<Event> getEventsPagination(
      {@required int page, @required String token}) {
    return _eventProvider.getEventsPagingation(page: page, token: token);
  }

  Future<Content> getEventContentById(
      {@required int eventId, @required String token}) {
    return _eventProvider.getEventContentById(eventId: eventId, token: token);
  }

  Future<List<Content>> searchEventByTitle({@required String keyWord, @required String token}){
    return _eventProvider.searchEventByTitle(keyWord: keyWord, token: token);
  }
}
