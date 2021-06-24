import 'dart:convert';

Vocabulary vocabularyFromJson(String str) => Vocabulary.fromJson(json.decode(str));

String vocabularyToJson(Vocabulary data) => json.encode(data.toJson());

class Vocabulary {
  Vocabulary({
    this.vocabularyId,
    this.vocabulary,
    this.description,
    this.imageLink,
    this.voiceLink,
  });

  int vocabularyId;
  String vocabulary;
  String description;
  String imageLink;
  String voiceLink;

  factory Vocabulary.fromJson(Map<String, dynamic> json) => Vocabulary(
    vocabularyId: json["vocabularyId"],
    vocabulary: json["vocabulary"],
    description: json["description"],
    imageLink: json["image_link"],
    voiceLink: json["voice_link"],
  );

  Map<String, dynamic> toJson() => {
    "vocabularyId": vocabularyId,
    "vocabulary": vocabulary,
    "description": description,
    "image_link": imageLink,
    "voice_link": voiceLink,
  };
}

