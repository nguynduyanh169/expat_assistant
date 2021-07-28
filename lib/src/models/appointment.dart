// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/models/specialist.dart';

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
    Appointment({
        this.conAppId,
        this.session,
        this.expat,
        this.language,
        this.major,
        this.createDate,
        this.rating,
        this.comment,
        this.status,
    });

    int conAppId;
    Session session;
    ExpatProfile expat;
    dynamic language;
    dynamic major;
    List<int> createDate;
    dynamic rating;
    dynamic comment;
    dynamic status;

    factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        conAppId: json["conAppId"],
        session: Session.fromJson(json["session"]),
        expat: ExpatProfile.fromJson(json["expat"]),
        language: json["language"],
        major: json["major"],
        createDate: List<int>.from(json["createDate"].map((x) => x)),
        rating: json["rating"],
        comment: json["comment"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "conAppId": conAppId,
        "session": session.toJson(),
        "expat": expat.toJson(),
        "language": language,
        "major": major,
        "createDate": List<dynamic>.from(createDate.map((x) => x)),
        "rating": rating,
        "comment": comment,
        "status": status,
    };
}




