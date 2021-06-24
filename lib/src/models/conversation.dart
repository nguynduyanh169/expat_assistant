// To parse this JSON data, do
//
//     final conversation = conversationFromJson(jsonString);

import 'dart:convert';

import 'package:expat_assistant/src/models/topic.dart';

Conversation conversationFromJson(String str) => Conversation.fromJson(json.decode(str));

String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
  Conversation({
    this.conversationId,
    this.topic,
    this.conversation,
    this.description,
    this.conversationImage,
    this.voiceLink,
  });

  int conversationId;
  Topic topic;
  String conversation;
  String description;
  String conversationImage;
  String voiceLink;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    conversationId: json["conversationId"],
    topic: Topic.fromJson(json["topic"]),
    conversation: json["conversation"],
    description: json["description"],
    conversationImage: json["conversationImage"],
    voiceLink: json["voice_link"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "topic": topic.toJson(),
    "conversation": conversation,
    "description": description,
    "conversationImage": conversationImage,
    "voice_link": voiceLink,
  };
}

