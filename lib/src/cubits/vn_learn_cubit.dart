import 'dart:io';

import 'package:android_external_storage/android_external_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/conversation.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/models/vocabulary.dart';
import 'package:expat_assistant/src/repositories/conversation_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/repositories/vocabulary_repository.dart';
import 'package:expat_assistant/src/states/vn_learn_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class VNlearnCubit extends Cubit<VNlearnState> {
  TopicRepository _topicRepository;
  ConversationRepository _conversationRepository;
  VocabularyRepository _vocabularyRepository;
  HiveUtils _hiveUtils = HiveUtils();

  VNlearnCubit(this._topicRepository, this._conversationRepository,
      this._vocabularyRepository)
      : super(const VNlearnState());

  Future<void> getAllTopic() async {
    emit(state.copyWith(status: VNlearnStatus.loading));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      List<Topic> result = await _topicRepository.getAllTopic(token: token);
      if (result != null) {
        for (Topic topic in result) {
          LessonLocal lessonLocal = LessonLocal(topic.topicId, topic.topicName,
              topic.topicDesc, topic.topicImage);
          if (!_hiveUtils.haveLesson(
              boxName: HiveBoxName.LESSON, key: lessonLocal.id)) {
            _hiveUtils.addLesson(
                boxName: HiveBoxName.LESSON, lessonLocal: lessonLocal);
          }
          var path =
              await AndroidExternalStorage.getExternalStoragePublicDirectory(
                  DirType.documentsDirectory);
          String filePath = '$path/${lessonLocal.name}/${lessonLocal.name}.png';
          LessonFileLocal lessonFileLocal =
              LessonFileLocal(lessonLocal.imageLink, filePath);
          if (!_hiveUtils.haveFilePath(
              boxName: HiveBoxName.LESSON_SRC, key: lessonFileLocal.link)) {
            var status = await Permission.storage.status;
            if (!status.isGranted) {
              await Permission.storage.request();
            }
            await Flowder.download(
                lessonLocal.imageLink,
                DownloaderUtils(
                  progressCallback: (current, total) {
                    final progress = (current / total) * 100;
                    print('Downloading: $progress');
                  },
                  file: File(filePath),
                  progress: ProgressImplementation(),
                  onDone: () {
                    _hiveUtils.addFilePath(
                        boxName: HiveBoxName.LESSON_SRC,
                        lessonFileLocal: lessonFileLocal);
                  },
                  deleteOnCancel: true,
                ));
          }
        }
        emit(state.copyWith(
            status: VNlearnStatus.loadSuccess,
            lessonLocalList:
                _hiveUtils.getAllLesson(boxName: HiveBoxName.LESSON)));
      } else {
        emit(state.copyWith(
            status: VNlearnStatus.loadFailed, error: 'Load Failed!'));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
          status: VNlearnStatus.loadFailed, error: e.toString()));
    }
  }

  Future<void> downloadConversation(int lessonId, String lessonName) async {
    List<ConversationLocal> _conversationLocals = [];
    emit(state.copyWith(status: VNlearnStatus.downloadingConversation));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      List<Conversation> result = await _conversationRepository
          .findConversationsByLessonId(topicId: lessonId, token: token);
      if (result != null) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
        for (Conversation conversation in result) {
          ConversationLocal conversationLocal = ConversationLocal(
              conversation.conversationId,
              conversation.conversation,
              conversation.description,
              conversation.conversationImage,
              conversation.voiceLink);
          _conversationLocals.add(conversationLocal);
          var path =
              await AndroidExternalStorage.getExternalStoragePublicDirectory(
                  DirType.documentsDirectory);
          String imagePath =
              '$path/$lessonName/conversation/${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}.png';
          String audioPath =
              '$path/$lessonName/conversation/${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}.mp3';
          if (conversationLocal.imageLink != null) {
            await Flowder.download(
                conversationLocal.imageLink,
                DownloaderUtils(
                  progressCallback: (current, total) {
                    final int progress = ((current / total) * 100).toInt();
                    print('downloading: ' + progress.toString());
                  },
                  file: File(imagePath),
                  progress: ProgressImplementation(),
                  onDone: () {
                    LessonFileLocal lessonFileLocal =
                        LessonFileLocal(conversationLocal.imageLink, imagePath);
                    _hiveUtils.addFilePath(
                        boxName: HiveBoxName.LESSON_SRC,
                        lessonFileLocal: lessonFileLocal);
                  },
                  deleteOnCancel: true,
                ));
          }
          if (conversationLocal.voiceLink != null) {
            await Flowder.download(
                conversationLocal.voiceLink,
                DownloaderUtils(
                  progressCallback: (current, total) {
                    final int progress = ((current / total) * 100).toInt();
                    print('downloading: ' + progress.toString());
                  },
                  file: File(audioPath),
                  progress: ProgressImplementation(),
                  onDone: () {
                    LessonFileLocal lessonFileLocal =
                        LessonFileLocal(conversationLocal.voiceLink, audioPath);
                    _hiveUtils.addFilePath(
                        boxName: HiveBoxName.LESSON_SRC,
                        lessonFileLocal: lessonFileLocal);
                  },
                  deleteOnCancel: true,
                ));
          }
        }
        _hiveUtils.addConversation(
            conversationBox: HiveBoxName.CONVERSATION,
            list: _conversationLocals,
            lessonBox: HiveBoxName.LESSON,
            lessonKey: lessonId);
        emit(state.copyWith(
            status: VNlearnStatus.downloadConversationSuccess,
            lessonLocalList:
                _hiveUtils.getAllLesson(boxName: HiveBoxName.LESSON)));
      } else {
        emit(state.copyWith(
            status: VNlearnStatus.downloadConversationFailed,
            error: 'Download Failed!'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: VNlearnStatus.downloadConversationFailed,
          error: e.toString()));
    }
  }

  Future<void> downloadVocabulary(
      int lessonId, String lessonName, BuildContext context) async {
    List<VocabularyLocal> _vocabularyLocals = [];
    emit(state.copyWith(status: VNlearnStatus.downloadingVocabulary));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      List<Vocabulary> result = await _vocabularyRepository
          .getVocabulariesByLessonId(lessonId: lessonId, token: token);
      if (result != null) {
        for (Vocabulary vocabulary in result) {
          VocabularyLocal vocabularyLocal = VocabularyLocal(
              vocabulary.vocabularyId,
              vocabulary.vocabulary,
              vocabulary.description,
              vocabulary.imageLink,
              vocabulary.voiceLink);
          _vocabularyLocals.add(vocabularyLocal);
          var path =
              await AndroidExternalStorage.getExternalStoragePublicDirectory(
                  DirType.documentsDirectory);
          String imagePath =
              '$path/$lessonName/vocabulary/${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}.png';
          String audioPath =
              '$path/$lessonName/vocabulary/${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}.mp3';
          if (vocabularyLocal.imageLink != null) {
            await Flowder.download(
                vocabularyLocal.imageLink,
                DownloaderUtils(
                  progressCallback: (current, total) {
                    final int progress = ((current / total) * 100).toInt();
                    print('downloading: ' + progress.toString());
                  },
                  file: File(imagePath),
                  progress: ProgressImplementation(),
                  onDone: () {
                    LessonFileLocal lessonFileLocal =
                        LessonFileLocal(vocabularyLocal.imageLink, imagePath);
                    _hiveUtils.addFilePath(
                        boxName: HiveBoxName.LESSON_SRC,
                        lessonFileLocal: lessonFileLocal);
                  },
                  deleteOnCancel: true,
                ));
          }
          if (vocabularyLocal.voiceLink != null) {
            await Flowder.download(
                vocabularyLocal.voiceLink,
                DownloaderUtils(
                  progressCallback: (current, total) {
                    final int progress = ((current / total) * 100).toInt();
                    print('downloading: ' + progress.toString());
                  },
                  file: File(audioPath),
                  progress: ProgressImplementation(),
                  onDone: () {
                    LessonFileLocal lessonFileLocal =
                        LessonFileLocal(vocabularyLocal.voiceLink, audioPath);
                    _hiveUtils.addFilePath(
                        boxName: HiveBoxName.LESSON_SRC,
                        lessonFileLocal: lessonFileLocal);
                  },
                  deleteOnCancel: true,
                ));
          }
        }
        _hiveUtils.addVocabulary(
            vocabularyBox: HiveBoxName.VOCABULARY,
            list: _vocabularyLocals,
            lessonBox: HiveBoxName.LESSON,
            lessonKey: lessonId);
        emit(state.copyWith(
            status: VNlearnStatus.downloadVocabularySuccess,
            lessonLocalList:
                _hiveUtils.getAllLesson(boxName: HiveBoxName.LESSON)));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
          status: VNlearnStatus.downloadVocabularyFailed, error: e.toString()));
    }
  }

  Future<void> searchLesson(
      List<LessonLocal> lessonList, String keyword) async {
    List<LessonLocal> results = [];
    if (keyword.isEmpty) {
      results = _hiveUtils.getAllLesson(boxName: HiveBoxName.LESSON);
    } else {
      results = lessonList
          .where((lesson) =>
              lesson.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    if (results.length == 0) {
      emit(state.copyWith(status: VNlearnStatus.searchFailed));
    } else {
      emit(state.copyWith(
          status: VNlearnStatus.searchSuccess, lessonLocalList: results));
    }
  }
}
