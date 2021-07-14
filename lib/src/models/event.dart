import 'dart:collection';
import 'dart:convert';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/models/location.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:table_calendar/table_calendar.dart';

class EventDemo {
  final String title;
  final DateTime dateTime;

  const EventDemo(this.title, this.dateTime);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<EventDemo>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(2020, 10, item * 5),
    value: (item) => List.generate(
        item % 4 + 1,
        (index) => EventDemo(
            'Event $item | ${index + 1}', DateTime.utc(2020, 10, item * 5))))
  ..addAll({
    DateTime.now(): [
      EventDemo('Today\'s Event 1', DateTime.now()),
      EventDemo('Today\'s Event 2', DateTime.now()),
    ],
  });

// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.sort,
    this.size,
    this.number,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  List<Content> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  Sort sort;
  int size;
  int number;
  int numberOfElements;
  bool first;
  bool empty;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        sort: Sort.fromJson(json["sort"]),
        size: json["size"],
        number: json["number"],
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "last": last,
        "sort": sort.toJson(),
        "size": size,
        "number": number,
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
      };
}

class Content {
  Content(
      {this.eventId,
      this.eventTitle,
      this.eventDesc,
      this.eventCoverImage,
      this.eventStatus,
      this.eventStartDate,
      this.eventEndDate,
      this.createBy,
      this.createDate,
      this.organizers});

  int eventId;
  String eventTitle;
  String eventDesc;
  String eventCoverImage;
  String eventStatus;
  List<int> eventStartDate;
  List<int> eventEndDate;
  String createBy;
  List<int> createDate;
  String organizers;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
      eventId: json["eventId"],
      eventTitle: json["eventTitle"],
      eventDesc: json["eventDesc"],
      eventCoverImage: json["eventCoverImage"],
      eventStatus: json["eventStatus"],
      eventStartDate: List<int>.from(json["eventStartDate"].map((x) => x)),
      eventEndDate: List<int>.from(json["eventEndDate"].map((x) => x)),
      createBy: json["createBy"],
      createDate: List<int>.from(json["createDate"].map((x) => x)),
      organizers: json["organizers"]);

  Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "eventTitle": eventTitle,
        "eventDesc": eventDesc,
        "eventCoverImage": eventCoverImage,
        "eventStatus": eventStatus,
        "eventStartDate": List<dynamic>.from(eventStartDate.map((x) => x)),
        "eventEndDate": List<dynamic>.from(eventEndDate.map((x) => x)),
        "createBy": createBy,
        "createDate": List<dynamic>.from(createDate.map((x) => x)),
        "organizers": organizers
      };
}

class Pageable {
  Pageable({
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.paged,
    this.unpaged,
  });

  Sort sort;
  int pageNumber;
  int pageSize;
  int offset;
  bool paged;
  bool unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  Sort({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  bool sorted;
  bool unsorted;
  bool empty;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        unsorted: json["unsorted"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "unsorted": unsorted,
        "empty": empty,
      };
}

class EventExpat {
  EventExpat({
    this.expatEventId,
    this.expatId,
    this.eventId,
  });

  int expatEventId;
  Expat expatId;
  Content eventId;

  factory EventExpat.fromJson(Map<String, dynamic> json) => EventExpat(
        expatEventId: json["expatEventId"],
        expatId: Expat.fromJson(json["expatId"]),
        eventId: Content.fromJson(json["eventId"]),
      );

  Map<String, dynamic> toJson() => {
        "expatEventId": expatEventId,
        "expatId": expatId.toJson(),
        "eventId": eventId.toJson(),
      };
}

class EventShow {
  Content content;
  Location location;
  Topic topic;
  bool isJoined;

  EventShow({this.content, this.topic, this.location, this.isJoined});
}
