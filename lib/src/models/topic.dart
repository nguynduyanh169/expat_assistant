import 'dart:convert';

Topic topicFromJson(String str) => Topic.fromJson(json.decode(str));

String topicToJson(Topic data) => json.encode(data.toJson());

class Topic {
  Topic({
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
  int topicStatus;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
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