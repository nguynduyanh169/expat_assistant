import 'dart:io';

import 'package:android_external_storage/android_external_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/conversation.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/repositories/conversation_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/states/vn_learn_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flowder/flowder.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class VNlearnCubit extends Cubit<VNlearnState> {
  TopicRepository _topicRepository;
  ConversationRepository _conversationRepository;
  HiveUtils _hiveUtils = HiveUtils();

  VNlearnCubit(this._topicRepository, this._conversationRepository)
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
            status: VNlearnStatus.loadSuccess, lessonLocalList: _hiveUtils.getAllLesson(boxName: HiveBoxName.LESSON)));
      } else {
        emit(state.copyWith(
            status: VNlearnStatus.loadFailed, error: 'Load Failed!'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: VNlearnStatus.loadFailed, error: e.toString()));
    }
  }

  Future<void> downloadConversation(int lessonId) async {
    List<ConversationLocal> _conversationLocals = [];
    emit(state.copyWith(status: VNlearnStatus.downloadingConversation));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      List<Conversation> result = await _conversationRepository
          .findConversationsByLessonId(topicId: lessonId, token: token);
      if (result != null) {
        for (Conversation conversation in result) {
          ConversationLocal _conversationLocal = ConversationLocal(
              conversation.conversationId,
              conversation.conversation,
              conversation.description,
              conversation.conversationImage,
              conversation.voiceLink);
          _conversationLocals.add(_conversationLocal);
        }
        _hiveUtils.addConversation(
            conversationBox: HiveBoxName.CONVERSATION,
            list: _conversationLocals,
            lessonBox: HiveBoxName.LESSON,
            lessonKey: lessonId);

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
}
