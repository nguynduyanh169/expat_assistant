import 'package:hive/hive.dart';
part 'hive_object.g.dart';

@HiveType(typeId: 0)
class LessonLocal extends HiveObject{
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String des;

  @HiveField(3)
  final String imageLink;

  @HiveField(4)
  HiveList conversations;

  @HiveField(5)
  HiveList vocabularies;

  LessonLocal(this.id, this.name, this.des, this.imageLink);
}

@HiveType(typeId: 1)
class LessonFileLocal extends HiveObject{
  @HiveField(0)
  final String link;

  @HiveField(1)
  final String srcPath;

  LessonFileLocal(this.link, this.srcPath);

}

@HiveType(typeId: 2)
class ConversationLocal extends HiveObject{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String conversation;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageLink;

  @HiveField(4)
  final String voiceLink;

  ConversationLocal(this.id, this.conversation, this.description, this.imageLink, this.voiceLink);
}

@HiveType(typeId: 3)
class VocabularyLocal extends HiveObject{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String vocabulary;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageLink;

  @HiveField(4)
  final String voiceLink;

  VocabularyLocal(this.id, this.vocabulary, this.description, this.imageLink, this.voiceLink);
}