import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/specialist.dart';

enum FilterSpecialistStatus {
  init,
  loadingSpecialists,
  loadedSpecialist,
  loadSpecialError,
  filteringByMajor,
  filteredByMajor,
  filterByMajorError, filteringByDate, filteredByDate, filterByDateError
}

extension Expaination on FilterSpecialistStatus {
  bool get isInit => this == FilterSpecialistStatus.init;

  bool get isLoadingSpecialists =>
      this == FilterSpecialistStatus.loadingSpecialists;

  bool get isLoadSpecialistsSuccess =>
      this == FilterSpecialistStatus.loadedSpecialist;

  bool get isLoadSpecialistsFailed =>
      this == FilterSpecialistStatus.loadSpecialError;

  bool get isFilteringByMajor =>
      this == FilterSpecialistStatus.filteringByMajor;

  bool get isFilterByMajorSuccess =>
      this == FilterSpecialistStatus.filteredByMajor;

  bool get isFilterByMajorError =>
      this == FilterSpecialistStatus.filterByMajorError;
  
  bool get isFilteringByDate =>
      this == FilterSpecialistStatus.filteringByDate;

  bool get isFilterByDateSuccess =>
      this == FilterSpecialistStatus.filteredByDate;

  bool get isFilterByDateError =>
      this == FilterSpecialistStatus.filterByDateError;
}

class FilterSpecialistState extends Equatable {
  final List<SpecialistDetails> specialists;
  final List<SpecialistDetails> oldSpecialists;
  final List<SpecialistDetails> specialistsMajor;
  final List<SpecialistDetails> oldSpecialistsMajor;
  final List<SpecialistDetails> specialistsDate;
  final List<SpecialistDetails> oldSpecialistsDate;
  final int page;
  final FilterSpecialistStatus status;
  final bool isFirstFetch;

  const FilterSpecialistState(
      {this.oldSpecialists,
      this.specialists,
      this.isFirstFetch,
      this.page,
      this.status,
      this.oldSpecialistsMajor,
      this.specialistsMajor,
      this.oldSpecialistsDate,
      this.specialistsDate});

  @override
  // TODO: implement props
  List<Object> get props => [
        oldSpecialists,
        specialists,
        isFirstFetch,
        page,
        status,
        oldSpecialistsMajor,
        specialistsMajor,
        specialistsDate,
        oldSpecialistsDate
      ];

  FilterSpecialistState copyWith(
      {List<SpecialistDetails> specialists,
      List<SpecialistDetails> oldSpecialists,
      int page,
      FilterSpecialistStatus status,
      bool isFirstFetch,
      List<SpecialistDetails> specialistsMajor,
      List<SpecialistDetails> oldSpecialistsMajor,
      List<SpecialistDetails> specialistsDate,
      List<SpecialistDetails> oldSpecialistsDate}) {
    return FilterSpecialistState(
        specialists: specialists ?? this.specialists,
        oldSpecialists: oldSpecialists ?? this.oldSpecialists,
        page: page ?? this.page,
        status: status ?? this.status,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch,
        specialistsMajor: specialistsMajor ?? this.specialistsMajor,
        oldSpecialistsMajor: oldSpecialistsMajor ?? this.oldSpecialistsMajor,
        specialistsDate: specialistsDate ?? this.specialistsDate,
        oldSpecialistsDate: oldSpecialistsDate ?? this.oldSpecialistsDate);
  }
}
