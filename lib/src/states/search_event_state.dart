import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/event.dart';

class SearchEventState extends Equatable {
  final List<EventShow> searchEventList;
  final String message;
  final bool isLoading;
  final bool hasError;
  final SearchEventStatus status;

  const SearchEventState(
      {this.searchEventList,
      this.hasError,
      this.isLoading,
      this.message,
      this.status});

  @override
  // TODO: implement props
  List<Object> get props =>
      [searchEventList, hasError, isLoading, message, status];

  SearchEventState copyWith(
      {List<EventShow> searchEventList,
      String message,
      bool isLoading,
      bool hasError,
      SearchEventStatus status}) {
    return SearchEventState(
        searchEventList: searchEventList ?? this.searchEventList,
        message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        status: status ?? this.status);
  }
}

enum SearchEventStatus { init, searching, searchSuccess, searchError }

extension Explaination on SearchEventStatus {
  bool get isInit => this == SearchEventStatus.init;

  bool get isSearching => this == SearchEventStatus.searching;

  bool get isSearchSuccess => this == SearchEventStatus.searchSuccess;

  bool get isSearchError => this == SearchEventStatus.searchError;
}
