import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/specialist.dart';

class SearchSpecialistState extends Equatable {
  final List<SpecialistDetails> oldSpecialists;
  final List<SpecialistDetails> specialists;
  final int page;
  final SearchSpecialistStatus status;
  final String message;
  final bool isFirstFetch;

  const SearchSpecialistState(
      {this.oldSpecialists,
      this.specialists,
      this.message,
      this.page,
      this.isFirstFetch,
      this.status});
  @override
  // TODO: implement props
  List<Object> get props =>
      [oldSpecialists, specialists, page, message, isFirstFetch, status];

  SearchSpecialistState copyWith(
      {List<SpecialistDetails> oldSpecialists,
      List<SpecialistDetails> specialists,
      int page,
      SearchSpecialistStatus status,
      String message,
      bool isFirstFetch}) {
    return SearchSpecialistState(
        specialists: specialists ?? this.specialists,
        oldSpecialists: oldSpecialists ?? this.oldSpecialists,
        page: page ?? this.page,
        status: status ?? this.status,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch,
        message: message ?? this.message);
  }
}

enum SearchSpecialistStatus { init, searching, searchSuccess, searchFailed }

extension Explaination on SearchSpecialistStatus {
  bool get isInit => this == SearchSpecialistStatus.init;

  bool get isSearching => this == SearchSpecialistStatus.searching;

  bool get isSearchSuccess => this == SearchSpecialistStatus.searchSuccess;

  bool get isSearchError => this == SearchSpecialistStatus.searchFailed;
}
