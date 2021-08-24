import 'dart:collection';
import "package:collection/collection.dart";
import 'package:expat_assistant/src/models/appointment.dart';
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

  List<SessionDisplay> addSession(
      {List<Session> sessions, List<ExpatAppointment> appointments}) {
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
      int index = -1;
      if (appointments != null) {
        index = appointments.indexWhere((element) => checkDuplicateSession(
            startDate,
            endDate,
            DateTime(
                element.session.startTime[0],
                element.session.startTime[1],
                element.session.startTime[2],
                element.session.startTime[3],
                element.session.startTime[4]),
            DateTime(
                element.session.endTime[0],
                element.session.endTime[1],
                element.session.endTime[2],
                element.session.endTime[3],
                element.session.endTime[4])));
      }

      if (session.status == 2 || session.status == 0 || index >= 0) {
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

  bool checkDuplicateSession(
      DateTime startDateOfSession,
      DateTime endDateOfSession,
      DateTime startDateOfAppointment,
      DateTime endDateOfAppointment) {
    //apointment 16:00 17:00
    bool check = false;
    if (startDateOfSession.isAtSameMomentAs(startDateOfAppointment)) {
      check = true;
    } else if (startDateOfSession.isAfter(startDateOfAppointment) &&
        endDateOfSession.isBefore(endDateOfAppointment)) {
      check = true;
    } else if (startDateOfSession.isBefore(startDateOfAppointment) &&
        endDateOfSession.isAfter(startDateOfAppointment) &&
        endDateOfSession.isBefore(endDateOfAppointment)) {
      //15:30 - 16:30
      check = true;
    } else if (startDateOfSession.isAfter(startDateOfAppointment) &&
        startDateOfSession.isBefore(endDateOfAppointment)) {
      check = true;
    } else if (startDateOfSession.isBefore(startDateOfAppointment) &&
        endDateOfSession.isAfter(endDateOfAppointment)) {
      check = true;
    }
    return check;
  }
}
