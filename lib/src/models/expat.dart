// To parse this JSON data, do
//
//     final expat = expatFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Expat expatFromJson(String str) => Expat.fromJson(json.decode(str));

String expatToJson(Expat data) => json.encode(data.toJson());

class Expat {
  Expat({
    this.avataLink,
    this.email,
    this.fullname,
    this.languages,
    this.nationEntity,
    this.password,
    this.phone,
  });

  String avataLink;
  String email;
  String fullname;
  List<Language> languages;
  String nationEntity;
  String password;
  String phone;

  factory Expat.fromJson(Map<String, dynamic> json) => Expat(
        avataLink: json["avataLink"],
        email: json["email"],
        fullname: json["fullname"],
        languages: json["languages"] != null
            ? List<Language>.from(
                json["languages"].map((x) => Language.fromJson(x)))
            : null,
        nationEntity: json["nationEntity"],
        password: json["password"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "avataLink": avataLink,
        "email": email,
        "fullname": fullname,
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
        "nationEntity": nationEntity,
        "password": password,
        "phone": phone,
      };
}

// ignore: must_be_immutable
class Language extends Equatable {
  Language({
    this.languageId,
    this.languageName,
  });

  int languageId;
  String languageName;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        languageId: json["languageId"],
        languageName: json["languageName"],
      );

  Map<String, dynamic> toJson() => {
        "languageId": languageId,
        "languageName": languageName,
      };

  @override
  // TODO: implement props
  List<Object> get props => [languageId, languageName];
}

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.languages,
    this.expat,
  });

  List<Language> languages;
  ExpatProfile expat;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        expat: ExpatProfile.fromJson(json["expat"]),
      );

  Map<String, dynamic> toJson() => {
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
        "expat": expat.toJson(),
      };
}

class ExpatProfile {
  ExpatProfile({
    this.id,
    this.nationEntity,
    this.email,
    this.password,
    this.fullname,
    this.phone,
    this.avatarLink,
  });

  int id;
  NationEntity nationEntity;
  String email;
  dynamic password;
  String fullname;
  String phone;
  String avatarLink;

  factory ExpatProfile.fromJson(Map<String, dynamic> json) => ExpatProfile(
        id: json["id"],
        nationEntity: NationEntity.fromJson(json["nationEntity"]),
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        phone: json["phone"],
        avatarLink: json["avatarLink"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nationEntity": nationEntity.toJson(),
        "email": email,
        "password": password,
        "fullname": fullname,
        "phone": phone,
        "avatarLink": avatarLink,
      };
}

// ignore: must_be_immutable
class NationEntity extends Equatable {
  NationEntity({
    this.nationId,
    this.nationName,
  });

  int nationId;
  String nationName;

  factory NationEntity.fromJson(Map<String, dynamic> json) => NationEntity(
        nationId: json["nationId"],
        nationName: json["nationName"],
      );

  Map<String, dynamic> toJson() => {
        "nationId": nationId,
        "nationName": nationName,
      };

  @override
  // TODO: implement props
  List<Object> get props => [nationId, nationName];
}
