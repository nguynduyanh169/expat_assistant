import 'dart:collection';
import "package:collection/collection.dart";
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class SessionUtils {
  final DateTimeUtils _dateTimeUtils = DateTimeUtils();
  LinkedHashMap<DateTime, List<SessionDisplay>> getSessiontToCalendar(
      {List<SessionDisplay> sessionLists}) {
    Map<DateTime, List<SessionDisplay>> result =
        groupBy(sessionLists, (obj) => obj.dateOfSession);
    final kSessions = LinkedHashMap<DateTime, List<SessionDisplay>>(
        equals: isSameDay, hashCode: getHashCode)
      ..addAll(result);
    return kSessions;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  double caculateTotalPrice({List<SessionDisplay> sessionLists}) {
    double price = 0;
    for (SessionDisplay sessionDisplay in sessionLists) {
      price += sessionDisplay.price;
    }
    return price;
  }

  List<SessionDisplay> addSession({List<Session> sessions}) {
    List<SessionDisplay> result = [];
    for (Session session in sessions) {
      DateTime dateOfSession = DateTime(
          session.startTime[0], session.startTime[1], session.startTime[2]);
      DateTime startDate = DateTime(session.startTime[0], session.startTime[1],
          session.startTime[2], session.startTime[3], session.startTime[4]);
      String startTime = _dateTimeUtils.getTime(startDate);
      DateTime endDate = DateTime(session.endTime[0], session.endTime[1],
          session.endTime[2], session.endTime[3], session.endTime[4]);
      String endTime = _dateTimeUtils.getTime(endDate);
      if (session.status == 2 || session.status == 0) {
        SessionDisplay sessionDisplay = SessionDisplay(
            dateOfSession: dateOfSession,
            startDate: startDate,
            sessionId: session.consultId,
            startTime: startTime,
            endTime: endTime,
            isChoosen: false,
            price: session.price,
            status: session.status,
            isDisable: true);
        result.add(sessionDisplay);
      } else {
        SessionDisplay sessionDisplay = SessionDisplay(
            dateOfSession: dateOfSession,
            startDate: startDate,
            sessionId: session.consultId,
            startTime: startTime,
            endTime: endTime,
            isChoosen: false,
            price: session.price,
            status: session.status,
            isDisable: false);
        result.add(sessionDisplay);
      }
    }
    return result;
  }

  bool checkDisableSession(SessionDisplay sessionDisplay) {
    bool cannotChoose = false;
    if (sessionDisplay.isDisable == true) {
      cannotChoose = true;
    }
    if (sessionDisplay.startDate.isBefore(DateTime.now())) {
      cannotChoose = true;
    }
    return cannotChoose;
  }
}
