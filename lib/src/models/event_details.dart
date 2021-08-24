// To parse this JSON data, do
//
//     final eventDetails = eventDetailsFromJson(jsonString);

import 'dart:convert';

EventDetails eventDetailsFromJson(String str) =>
    EventDetails.fromJson(json.decode(str));

String eventDetailsToJson(EventDetails data) => json.encode(data.toJson());

class EventDetails {
  EventDetails({
    this.event,
    this.topic,
    this.location,
  });

  EventContent event;
  List<TopicDetails> topic;
  List<LocationDetails> location;

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
        event: EventContent.fromJson(json["Event"]),
        topic: List<TopicDetails>.from(
            json["Topic"].map((x) => TopicDetails.fromJson(x))),
        location: List<LocationDetails>.from(
            json["Location"].map((x) => LocationDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Event": event.toJson(),
        "Topic": List<dynamic>.from(topic.map((x) => x.toJson())),
        "Location": List<dynamic>.from(location.map((x) => x.toJson())),
      };
}

class EventContent {
  EventContent({
    this.eventId,
    this.eventTitle,
    this.eventDesc,
    this.eventCoverImage,
    this.eventStatus,
    this.eventStartDate,
    this.eventEndDate,
    this.createBy,
    this.createDate,
    this.organizers,
  });

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

  factory EventContent.fromJson(Map<String, dynamic> json) => EventContent(
        eventId: json["eventId"],
        eventTitle: json["eventTitle"],
        eventDesc: json["eventDesc"],
        eventCoverImage: json["eventCoverImage"],
        eventStatus: json["eventStatus"],
        eventStartDate: List<int>.from(json["eventStartDate"].map((x) => x)),
        eventEndDate: List<int>.from(json["eventEndDate"].map((x) => x)),
        createBy: json["createBy"],
        createDate: List<int>.from(json["createDate"].map((x) => x)),
        organizers: json["organizers"],
      );

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
        "organizers": organizers,
      };
}

class LocationDetails {
  LocationDetails({
    this.eventLocationId,
    this.eventId,
    this.locationId,
  });

  int eventLocationId;
  EventContent eventId;
  LocationId locationId;

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      LocationDetails(
        eventLocationId: json["eventLocationId"],
        eventId: EventContent.fromJson(json["eventId"]),
        locationId: LocationId.fromJson(json["locationId"]),
      );

  Map<String, dynamic> toJson() => {
        "eventLocationId": eventLocationId,
        "eventId": eventId.toJson(),
        "locationId": locationId.toJson(),
      };
}

class LocationId {
  LocationId({
    this.locationId,
    this.locationType,
    this.locationName,
    this.locationAddress,
    this.locationLatitude,
    this.locationLongitude,
    this.locationImageLink,
    this.openTime,
    this.closeTime,
  });

  int locationId;
  LocationType locationType;
  String locationName;
  String locationAddress;
  double locationLatitude;
  double locationLongitude;
  String locationImageLink;
  List<int> openTime;
  List<int> closeTime;

  factory LocationId.fromJson(Map<String, dynamic> json) => LocationId(
        locationId: json["locationId"],
        locationType: LocationType.fromJson(json["locationType"]),
        locationName: json["locationName"],
        locationAddress: json["locationAddress"],
        locationLatitude: json["locationLatitude"].toDouble(),
        locationLongitude: json["locationLongitude"].toDouble(),
        locationImageLink: json["locationImageLink"],
        openTime: List<int>.from(json["open_time"].map((x) => x)),
        closeTime: List<int>.from(json["close_time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "locationType": locationType.toJson(),
        "locationName": locationName,
        "locationAddress": locationAddress,
        "locationLatitude": locationLatitude,
        "locationLongitude": locationLongitude,
        "locationImageLink": locationImageLink,
        "open_time": List<dynamic>.from(openTime.map((x) => x)),
        "close_time": List<dynamic>.from(closeTime.map((x) => x)),
      };
}

class LocationType {
  LocationType({
    this.typeId,
    this.type,
  });

  int typeId;
  String type;

  factory LocationType.fromJson(Map<String, dynamic> json) => LocationType(
        typeId: json["typeId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "typeId": typeId,
        "type": type,
      };
}

class TopicDetails {
  TopicDetails({
    this.eventTopicId,
    this.topicId,
    this.eventId,
  });

  int eventTopicId;
  TopicId topicId;
  EventContent eventId;

  factory TopicDetails.fromJson(Map<String, dynamic> json) => TopicDetails(
        eventTopicId: json["eventTopicId"],
        topicId: TopicId.fromJson(json["topicId"]),
        eventId: EventContent.fromJson(json["eventId"]),
      );

  Map<String, dynamic> toJson() => {
        "eventTopicId": eventTopicId,
        "topicId": topicId.toJson(),
        "eventId": eventId.toJson(),
      };
}

class TopicId {
  TopicId({
    this.topicId,
    this.topicName,
    this.topicDesc,
    this.topicImage,
    this.topicStatus,
  });

  int topicId;
  String topicName;
  String topicDesc;
  String topicImage;
  dynamic topicStatus;

  factory TopicId.fromJson(Map<String, dynamic> json) => TopicId(
        topicId: json["topicId"],
        topicName: json["topicName"],
        topicDesc: json["topicDesc"],
        topicImage: json["topicImage"],
        topicStatus: json["topicStatus"],
      );

  Map<String, dynamic> toJson() => {
        "topicId": topicId,
        "topicName": topicName,
        "topicDesc": topicDesc,
        "topicImage": topicImage,
        "topicStatus": topicStatus,
      };
}
