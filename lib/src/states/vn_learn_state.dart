import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/models/topic.dart';

enum VNlearnStatus {
  loading,
  loadSuccess,
  loadFailed,
  downloadConversationSuccess,
  downloadingConversation,
  downloadConversationEmpty,
  downloadConversationFailed,
  downloadVocabularySuccess,
  downloadingVocabulary,
  dowloadVocabularyEmpty,
  downloadVocabularyFailed,
  searchSuccess,
  searchFailed,
}

extension Explanation on VNlearnStatus {
  bool get isLoading => this == VNlearnStatus.loading;

  bool get isLoadSuccess => this == VNlearnStatus.loadSuccess;

  bool get isLoadFailed => this == VNlearnStatus.loadFailed;

  bool get isDownloadingConversation =>
      this == VNlearnStatus.downloadingConversation;

  bool get isDownloadConversationSuccess =>
      this == VNlearnStatus.downloadConversationSuccess;

  bool get isDownloadConversationEmpty =>
      this == VNlearnStatus.downloadConversationEmpty;

  bool get isDownloadConversationFailed =>
      this == VNlearnStatus.downloadConversationFailed;

  bool get isDownloadingVocabulary =>
      this == VNlearnStatus.downloadingVocabulary;

  bool get isDownloadVocabularySuccess =>
      this == VNlearnStatus.downloadVocabularySuccess;

  bool get isDownloadVocabularyEmpty =>
      this == VNlearnStatus.downloadVocabularyFailed;

  bool get isDownloadVocabularyFailed =>
      this == VNlearnStatus.downloadVocabularyFailed;
  bool get isSearchSuccess => this == VNlearnStatus.searchSuccess;

  bool get isSearchFailed => this == VNlearnStatus.searchFailed;
}

class VNlearnState extends Equatable {
  final List<Topic> topicList;
  final String error;
  final VNlearnStatus status;
  final List<LessonLocal> lessonLocalList;

  const VNlearnState(
      {this.topicList, this.status, this.error, this.lessonLocalList});

  @override
  // TODO: implement props
  List<Object> get props => [topicList, status, error, lessonLocalList];

  VNlearnState copyWith(
      {List<Topic> topicList,
      String error,
      VNlearnStatus status,
      List<LessonLocal> lessonLocalList}) {
    return VNlearnState(
        topicList: topicList ?? this.topicList,
        status: status ?? this.status,
        error: error ?? this.error,
        lessonLocalList: lessonLocalList ?? this.lessonLocalList);
  }
}
