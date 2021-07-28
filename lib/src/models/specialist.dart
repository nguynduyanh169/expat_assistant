// To parse this JSON data, do
//
//     final specialist = specialistFromJson(jsonString);

import 'dart:convert';

Specialist specialistFromJson(String str) =>
    Specialist.fromJson(json.decode(str));

String specialistToJson(Specialist data) => json.encode(data.toJson());

class Specialist {
  Specialist({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.listSpec,
  });

  int totalItems;
  int totalPages;
  int currentPage;
  List<ListSpec> listSpec;

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        listSpec: List<ListSpec>.from(
            json["listSpec"].map((x) => ListSpec.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "listSpec": List<dynamic>.from(listSpec.map((x) => x.toJson())),
      };
}

class ListSpec {
  ListSpec({
    this.specId,
    this.fullname,
    this.email,
    this.password,
    this.avatar,
    this.biography,
    this.status,
    // this.createDate,
    // this.updateDate,
    this.rating,
  });

  int specId;
  String fullname;
  String email;
  String password;
  String avatar;
  String biography;
  int status;
  // List<int> createDate;
  // List<int> updateDate;
  double rating;

  factory ListSpec.fromJson(Map<String, dynamic> json) => ListSpec(
        specId: json["specId"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
        biography: json["biography"],
        status: json["status"],
        // createDate: List<int>.from(json["createDate"].map((x) => x)),
        // updateDate: List<int>.from(json["updateDate"].map((x) => x)),
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "specId": specId,
        "fullname": fullname,
        "email": email,
        "password": password,
        "avatar": avatar,
        "biography": biography,
        "status": status,
        // "createDate": List<dynamic>.from(createDate.map((x) => x)),
        // "updateDate": List<dynamic>.from(updateDate.map((x) => x)),
        "rating": rating,
      };
}

SpecialistDetails specialistDetailsFromJson(String str) =>
    SpecialistDetails.fromJson(json.decode(str));

String specialistDetailsToJson(SpecialistDetails data) =>
    json.encode(data.toJson());

class SpecialistDetails {
  SpecialistDetails(
      {this.sessions, this.majors, this.specialist, this.language});

  List<Session> sessions;
  List<Major> majors;
  ListSpec specialist;
  List<Language> language;

  factory SpecialistDetails.fromJson(Map<String, dynamic> json) =>
      SpecialistDetails(
          sessions:
              List<Session>.from(
                  json["sessions"].map((x) => Session.fromJson(x))),
          majors:
              List<Major>.from(json["majors"].map((x) => Major.fromJson(x))),
          specialist: ListSpec.fromJson(json["Specialist"]),
          language: List<Language>.from(
              json["language"].map((x) => Language.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
        "majors": List<dynamic>.from(majors.map((x) => x.toJson())),
        "Specialist": specialist.toJson(),
        "language": List<dynamic>.from(language.map((x) => x.toJson())),
      };
}

class Major {
  Major({
    this.majorId,
    this.name,
  });

  int majorId;
  String name;

  factory Major.fromJson(Map<String, dynamic> json) => Major(
        majorId: json["majorId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "majorId": majorId,
        "name": name,
      };
}

class Language {
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
}

class Session {
  Session({
    this.consultId,
    this.specialist,
    this.startTime,
    this.endTime,
    this.price,
    this.status,
  });

  int consultId;
  ListSpec specialist;
  List<int> startTime;
  List<int> endTime;
  double price;
  int status;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        consultId: json["consultId"],
        specialist: ListSpec.fromJson(json["specialist"]),
        startTime: List<int>.from(json["startTime"].map((x) => x)),
        endTime: List<int>.from(json["endTime"].map((x) => x)),
        price: json["price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "consultId": consultId,
        "specialist": specialist.toJson(),
        "startTime": List<dynamic>.from(startTime.map((x) => x)),
        "endTime": List<dynamic>.from(endTime.map((x) => x)),
        "price": price,
        "status": status,
      };
}

