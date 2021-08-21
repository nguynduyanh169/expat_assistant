import 'package:expat_assistant/src/models/event.dart';
import 'package:flutter/material.dart';

class EventUtils {
  static String getEventStatus(EventShow event) {
    String result;
    Map<int, String> listStatus = {
      1: 'Scheduled',
      2: 'On-hold',
      3: 'In progress',
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

  static bool checkJoinEvent(EventShow event) {
    bool check = true;
    if (event.content.eventStatus == '3') {
      check = false;
    }
    if (event.content.eventStatus == '4') {
      check = false;
    }
    if (event.content.eventStatus == '5') {
      check = false;
    }
    if (DateTime(
            event.content.eventStartDate[0],
            event.content.eventStartDate[1],
            event.content.eventStartDate[2],
            event.content.eventStartDate[3],
            event.content.eventStartDate[4])
        .isBefore(DateTime.now().subtract(Duration(hours: 1)))) {
      check = false;
    }
    return check;
  }
}
