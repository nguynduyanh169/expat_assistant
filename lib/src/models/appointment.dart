

import 'dart:convert';

import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/models/specialist.dart';

ExpatAppointment appointmentFromJson(String str) =>
    ExpatAppointment.fromJson(json.decode(str));

String appointmentToJson(ExpatAppointment data) => json.encode(data.toJson());

class AppointmentMajor {
  AppointmentMajor({
    this.majorId,
    this.name,
  });

  int majorId;
  String name;

  factory AppointmentMajor.fromJson(Map<String, dynamic> json) =>
      AppointmentMajor(
        majorId: json["majorId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "majorId": majorId,
        "name": name,
      };
}

class ExpatAppointment {
  ExpatAppointment(
      {this.conAppId,
      this.session,
      this.expat,
      this.language,
      this.major,
      this.createDate,
      this.rating,
      this.comment,
      this.status,
      this.channelName});

  int conAppId;
  Session session;
  ExpatProfile expat;
  dynamic language;
  AppointmentMajor major;
  List<int> createDate;
  dynamic rating;
  dynamic comment;
  dynamic status;
  String channelName;

  factory ExpatAppointment.fromJson(Map<String, dynamic> json) =>
      ExpatAppointment(
          conAppId: json["conAppId"],
          session: Session.fromJson(json["session"]),
          expat: ExpatProfile.fromJson(json["expat"]),
          language: json["language"],
          major: json["major"] == null
              ? null
              : AppointmentMajor.fromJson(json["major"]),
          createDate: List<int>.from(json["createDate"].map((x) => x)),
          rating: json["rating"],
          comment: json["comment"],
          status: json["status"],
          channelName: json["channelName"]);

  Map<String, dynamic> toJson() => {
        "conAppId": conAppId,
        "session": session.toJson(),
        "expat": expat.toJson(),
        "language": language,
        "major": major.toJson(),
        "createDate": List<dynamic>.from(createDate.map((x) => x)),
        "rating": rating,
        "comment": comment,
        "status": status,
        "channelName": channelName
      };
}
