import 'package:expat_assistant/src/models/event.dart';
import 'package:flutter/material.dart';

class EventUtils {
  static String getEventStatus(EventShow event) {
    String result;
    Map<int, String> listStatus = {
      1: 'Scheduled',
      2: 'On-hold',
      3: 'Happening',
      4: 'Canceled',
      5: 'Completed'
    };
    result = listStatus[int.parse(event.content.eventStatus)];
    if (DateTime(
            event.content.eventStartDate[0],
            event.content.eventStartDate[1],
            event.content.eventStartDate[2],
            event.content.eventStartDate[3],
            event.content.eventStartDate[4])
        .isBefore(DateTime.now())) {
      if (event.content.eventStatus == '1') {
        result = 'Expired';
      }
    }
    return result;
  }

  static String getEventStatusForDetails(EventShowDetails event) {
    String result;
    Map<int, String> listStatus = {
      1: 'Scheduled',
      2: 'On-hold',
      3: 'Happening',
      4: 'Canceled',
      5: 'Completed'
    };
    result = listStatus[int.parse(event.content.event.eventStatus)];
    if (DateTime(
            event.content.event.eventStartDate[0],
             event.content.event.eventStartDate[1],
             event.content.event.eventStartDate[2],
             event.content.event.eventStartDate[3],
             event.content.event.eventStartDate[4])
        .isBefore(DateTime.now())) {
      if (event.content.event.eventStatus == '1') {
        result = 'Expired';
      }
    }
    return result;
  }

  static Color getEventStatusColor(EventShow event) {
    Color result;
    Map<int, Color> listStatus = {
      1: Colors.yellow,
      2: Colors.red,
      3: Colors.blue,
      4: Colors.grey,
      5: Colors.green
    };
    result = listStatus[int.parse(event.content.eventStatus)];
    if (DateTime(
            event.content.eventStartDate[0],
            event.content.eventStartDate[1],
            event.content.eventStartDate[2],
            event.content.eventStartDate[3],
            event.content.eventStartDate[4])
        .isBefore(DateTime.now())) {
      if (event.content.eventStatus == '1') {
        result = Colors.grey;
      }
    }
    return result;
  }

  static Color getEventStatusColorForDetails(EventShowDetails event) {
    Color result;
    Map<int, Color> listStatus = {
      1: Colors.yellow,
      2: Colors.red,
      3: Colors.blue,
      4: Colors.grey,
      5: Colors.green
    };
    result = listStatus[int.parse(event.content.event.eventStatus)];
    if (DateTime(
            event.content.event.eventStartDate[0],
            event.content.event.eventStartDate[1],
            event.content.event.eventStartDate[2],
            event.content.event.eventStartDate[3],
            event.content.event.eventStartDate[4])
        .isBefore(DateTime.now())) {
      if (event.content.event.eventStatus == '1') {
        result = Colors.grey;
      }
    }
    return result;
  }

  static List<EventStatus> getAllEventStatus() {
    List<EventStatus> result = [
      EventStatus(status: 1, content: 'Scheduled'),
      EventStatus(status: 2, content: 'On-hold'),
      EventStatus(status: 3, content: 'In Progress'),
      EventStatus(status: 4, content: 'Canceled'),
      EventStatus(status: 5, content: 'Completed')
    ];
    return result;
  }

  static bool checkJoinEvent(EventShowDetails event) {
    bool check = true;
    if (event.content.event.eventStatus == '3') {
      check = false;
    }
    if (event.content.event.eventStatus == '4') {
      check = false;
    }
    if (event.content.event.eventStatus == '5') {
      check = false;
    }
    if (DateTime(
            event.content.event.eventStartDate[0],
            event.content.event.eventStartDate[1],
            event.content.event.eventStartDate[2],
            event.content.event.eventStartDate[3],
            event.content.event.eventStartDate[4])
        .isBefore(DateTime.now().subtract(Duration(hours: 1)))) {
      check = false;
    }
    return check;
  }
}
