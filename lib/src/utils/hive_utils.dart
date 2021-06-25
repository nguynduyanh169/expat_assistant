import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class HiveUtils {
  bool haveToken({@required String boxName}) {
    final openBox = Hive.box(boxName);
    Map<dynamic, dynamic> userAuth = openBox.get('userAuth');
    return userAuth != null;
  }

  addUserAuth(
      {@required String email,
      @required String token,
      @required String boxName}) {
    final openBox = Hive.box(boxName);
    openBox.put('userAuth', {'email': email, 'token': token});
  }

  Map<dynamic, dynamic> getUserAuth({@required String boxName}){
    final openBox = Hive.box(boxName);
    Map<dynamic, dynamic> userAuth = openBox.get('userAuth');
    return userAuth;
  }

  deleteUserAuth({@required String boxName}) {
    final openBox = Hive.box(boxName);
    openBox.delete('userAuth');
  }

  bool haveLesson({@required String boxName, @required int key}){
    final openBox = Hive.box(boxName);
    LessonLocal lessonLocal = openBox.get(key);
    return lessonLocal != null;
  }

  addLesson({@required String boxName, @required LessonLocal lessonLocal}){
    final openBox = Hive.box(boxName);
    openBox.put(lessonLocal.id, lessonLocal);
  }

  LessonLocal getLesson({@required String boxName, @required int key}){
    final openBox = Hive.box(boxName);
    LessonLocal lessonLocal = openBox.get(key);
    return lessonLocal;
  }

  List<LessonLocal> getAllLesson({@required String boxName}){
    List<LessonLocal> result = [];
    final openBox = Hive.box(boxName);
    for(LessonLocal lessonLocal in openBox.values){
      result.add(lessonLocal);
    }
    return result;
  }


  deleteLesson({@required String boxName, @required int key}){
    final openBox = Hive.box(boxName);
    openBox.delete(key);
  }

  bool haveFilePath({@required String boxName, @required String key}){
    final openBox = Hive.box(boxName);
    LessonFileLocal lessonFileLocal = openBox.get(key);
    return lessonFileLocal != null;
  }

  addFilePath({@required String boxName, @required LessonFileLocal lessonFileLocal}){
    final openBox = Hive.box(boxName);
    openBox.put(lessonFileLocal.link, lessonFileLocal);
  }

  LessonFileLocal getFilePath({@required String boxName, @required String key}){
    final openBox = Hive.box(boxName);
    LessonFileLocal lessonFileLocal = openBox.get(key);
    return lessonFileLocal;
  }

  bool haveConversation({@required String boxName, @required String key}){
    final openBox = Hive.box(boxName);
    ConversationLocal conversationLocal = openBox.get(key);
    return conversationLocal != null;
  }

  addConversation({@required String conversationBox,@required String lessonBox, @required List<ConversationLocal> list, @required int lessonKey}){
    var conversations = Hive.box(conversationBox);
    conversations.addAll(list);
    var lessons = Hive.box(lessonBox);
    LessonLocal lesson = lessons.get(lessonKey);
    lesson.conversations = HiveList(conversations);
    lesson.conversations.addAll(list);
    lessons.delete(lessonKey);
    lessons.put(lessonKey, lesson);
  }


  ConversationLocal getConversation({@required String boxName, @required String key}){
    final openBox = Hive.box(boxName);
    ConversationLocal conversationLocal = openBox.get(key);
    return conversationLocal;
  }

  addVocabulary({@required String vocabularyBox, @required String lessonBox, @required List<VocabularyLocal> list, @required int lessonKey}){
    var vocabularies = Hive.box(vocabularyBox);
    vocabularies.addAll(list);
    var lessons = Hive.box(lessonBox);
    LessonLocal lesson = lessons.get(lessonKey);
    lesson.vocabularies = HiveList(vocabularies);
    lesson.vocabularies.addAll(list);
    lessons.delete(lessonKey);
    lessons.put(lessonKey, lesson);
  }

}
