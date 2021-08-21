import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/states/filter_specialist_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class FilterSpecialistsCubit extends Cubit<FilterSpecialistState> {
  SpecialistRepository _specialistRepository;
  HiveUtils _hiveUtils = HiveUtils();
  FilterSpecialistsCubit(this._specialistRepository)
      : super(const FilterSpecialistState(status: FilterSpecialistStatus.init));

  Future<void> getSpecialists(int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int size = 5;
      if (state.status.isLoadingSpecialists) return null;
      final currentState = state;
      List<SpecialistDetails> oldSpecialists = [];
      List<SpecialistDetails> specialists = [];
      if (currentState.status.isLoadSpecialistsSuccess) {
        oldSpecialists = state.specialists;
      }
      emit(state.copyWith(
        status: FilterSpecialistStatus.loadingSpecialists,
        oldSpecialists: oldSpecialists,
        isFirstFetch: page == 0,
      ));
      var specialist = await _specialistRepository.getSpecialistsByRating(
          token: token, page: page, size: size);
      if (specialist == 204) {
        emit(state.copyWith(
            page: page,
            status: FilterSpecialistStatus.loadedSpecialist,
            specialists: oldSpecialists));
      } else {
        page++;
        var specialistDetails = await fetchSpecialistsById(specialist, token);
        final thisSpecialists = state.oldSpecialists;
        specialists.addAll(thisSpecialists);
        specialists.addAll(specialistDetails);
        emit(state.copyWith(
            page: page,
            status: FilterSpecialistStatus.loadedSpecialist,
            specialists: specialists));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: FilterSpecialistStatus.loadSpecialError));
    }
  }

  Future<void> getSpecialistsByMajor(int page, int majorId) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isFilteringByMajor) return null;
      final currentState = state;
      List<SpecialistDetails> oldSpecialists = [];
      List<SpecialistDetails> specialists = [];
      if (currentState.status.isFilterByMajorSuccess) {
        oldSpecialists = state.specialistsMajor;
      }
      emit(state.copyWith(
        status: FilterSpecialistStatus.filteringByMajor,
        oldSpecialistsMajor: oldSpecialists,
        isFirstFetch: page == 0,
      ));
      var specialist = await _specialistRepository.getSpecialistByMajorId(
          token: token, page: page, majorId: majorId);
      if (specialist == 204) {
        emit(state.copyWith(
            page: page,
            status: FilterSpecialistStatus.filteredByMajor,
            specialistsMajor: oldSpecialists));
      } else {
        page++;
        var specialistDetails = await fetchSpecialistsById(specialist, token);
        final thisSpecialists = state.oldSpecialistsMajor;
        specialists.addAll(thisSpecialists);
        specialists.addAll(specialistDetails);
        print(specialists.length);
        emit(state.copyWith(
            page: page,
            status: FilterSpecialistStatus.filteredByMajor,
            specialistsMajor: specialists));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: FilterSpecialistStatus.filterByMajorError));
    }
  }

  Future<void> getSpecialistsByCreateDate(int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isFilteringByDate) return null;
      final currentState = state;
      List<SpecialistDetails> oldSpecialists = [];
      List<SpecialistDetails> specialists = [];
      if (currentState.status.isFilterByDateSuccess) {
        oldSpecialists = state.specialistsDate;
      }
      emit(state.copyWith(
        status: FilterSpecialistStatus.filteringByDate,
        oldSpecialistsDate: oldSpecialists,
        isFirstFetch: page == 0,
      ));
      var specialist = await _specialistRepository.getSpecialistByCreateDate(
          token: token, page: page);
      if (specialist == 204) {
        emit(state.copyWith(
            page: page,
            status: FilterSpecialistStatus.filteredByDate,
            specialistsDate: oldSpecialists));
      } else {
        page++;
        var specialistDetails = await fetchSpecialistsById(specialist, token);
        final thisSpecialists = state.oldSpecialistsDate;
        specialists.addAll(thisSpecialists);
        specialists.addAll(specialistDetails);
        emit(state.copyWith(
            page: page,
            status: FilterSpecialistStatus.filteredByDate,
            specialistsDate: specialists));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: FilterSpecialistStatus.filterByDateError));
    }
  }

  Future<List<SpecialistDetails>> fetchSpecialistsById(
      List<ListSpec> specialists, String token) async {
    print(specialists.length);
    List<SpecialistDetails> result = [];
    for (ListSpec spec in specialists) {
      SpecialistDetails specialistDetails = await _specialistRepository
          .getSpecialistInfo(token: token, specId: spec.specId);
      result.add(specialistDetails);
    }
    return result;
  }
}
