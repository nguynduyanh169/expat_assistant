// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonLocalAdapter extends TypeAdapter<LessonLocal> {
  @override
  final int typeId = 0;

  @override
  LessonLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonLocal(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    )
      ..conversations = (fields[4] as HiveList)?.castHiveList()
      ..vocabularies = (fields[5] as HiveList)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, LessonLocal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.des)
      ..writeByte(3)
      ..write(obj.imageLink)
      ..writeByte(4)
      ..write(obj.conversations)
      ..writeByte(5)
      ..write(obj.vocabularies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LessonFileLocalAdapter extends TypeAdapter<LessonFileLocal> {
  @override
  final int typeId = 1;

  @override
  LessonFileLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonFileLocal(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LessonFileLocal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.link)
      ..writeByte(1)
      ..write(obj.srcPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonFileLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConversationLocalAdapter extends TypeAdapter<ConversationLocal> {
  @override
  final int typeId = 2;

  @override
  ConversationLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConversationLocal(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConversationLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.conversation)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageLink)
      ..writeByte(4)
      ..write(obj.voiceLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VocabularyLocalAdapter extends TypeAdapter<VocabularyLocal> {
  @override
  final int typeId = 3;

  @override
  VocabularyLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyLocal(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vocabulary)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageLink)
      ..writeByte(4)
      ..write(obj.voiceLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationsAdapter extends TypeAdapter<Notifications> {
  @override
  final int typeId = 4;

  @override
  Notifications read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notifications(
      fields[1] as String,
      fields[3] as bool,
      fields[0] as String,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Notifications obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.sentDate)
      ..writeByte(3)
      ..write(obj.isView);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
