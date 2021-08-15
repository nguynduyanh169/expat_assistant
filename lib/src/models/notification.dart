// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

NotificationReceive notificationFromJson(String str) =>
    NotificationReceive.fromJson(json.decode(str));

String notificationToJson(NotificationReceive data) => json.encode(data.toJson());

class NotificationReceive {
  NotificationReceive({
    this.id,
    this.recipients,
    this.externalId,
  });

  String id;
  int recipients;
  dynamic externalId;

  factory NotificationReceive.fromJson(Map<String, dynamic> json) => NotificationReceive(
        id: json["id"],
        recipients: json["recipients"],
        externalId: json["external_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recipients": recipients,
        "external_id": externalId,
      };
}

// To parse this JSON data, do
//
//     final notificationSend = notificationSendFromJson(jsonString);


NotificationSend notificationSendFromJson(String str) => NotificationSend.fromJson(json.decode(str));

String notificationSendToJson(NotificationSend data) => json.encode(data.toJson());

class NotificationSend {
    NotificationSend({
        this.appId,
        this.includePlayerIds,
        this.headings,
        this.contents,
    });

    String appId;
    List<String> includePlayerIds;
    Contents headings;
    Contents contents;

    factory NotificationSend.fromJson(Map<String, dynamic> json) => NotificationSend(
        appId: json["app_id"],
        includePlayerIds: List<String>.from(json["include_player_ids"].map((x) => x)),
        headings: Contents.fromJson(json["headings"]),
        contents: Contents.fromJson(json["contents"]),
    );

    Map<String, dynamic> toJson() => {
        "app_id": appId,
        "include_player_ids": List<dynamic>.from(includePlayerIds.map((x) => x)),
        "headings": headings.toJson(),
        "contents": contents.toJson(),
    };
}

class Contents {
    Contents({
        this.en,
    });

    String en;

    factory Contents.fromJson(Map<String, dynamic> json) => Contents(
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
    };
}



