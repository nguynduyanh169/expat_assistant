// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

List<Location> locationFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  Location({
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

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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
