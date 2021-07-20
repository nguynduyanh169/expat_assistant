import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/major.dart';

class MajorFilterState extends Equatable {
  final List<Content> majors;
  final List<Content> oldMajors;
  final int page;
  final MajorFilterStatus status;
  final bool isFirstFetch;

  const MajorFilterState(
      {this.oldMajors, this.majors, this.page, this.isFirstFetch, this.status});
  @override
  // TODO: implement props
  List<Object> get props => [majors, page, isFirstFetch, oldMajors, status];

  MajorFilterState copyWith(
      {List<Content> majors,
      List<Content> oldMajors,
      int page,
      MajorFilterStatus status,
      bool isFirstFetch}) {
    return MajorFilterState(
        majors: majors ?? this.majors,
        oldMajors: oldMajors ?? this.oldMajors,
        page: page ?? this.page,
        status: status ?? this.status,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch);
  }
}

enum MajorFilterStatus { init, loadingMajors, loadedMajors, loadMajorsFailed }

extension Explaination on MajorFilterStatus {
  bool get isInit => this == MajorFilterStatus.init;

  bool get isLoadingMajors => this == MajorFilterStatus.loadingMajors;

  bool get isLoadedMajors => this == MajorFilterStatus.loadedMajors;

  bool get isLoadMajorsFailed => this == MajorFilterStatus.loadMajorsFailed;
}
