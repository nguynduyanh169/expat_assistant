import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/states/search_specialist_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class SearchSpecialistCubit extends Cubit<SearchSpecialistState> {
  SpecialistRepository _specialistRepository;
  HiveUtils _hiveUtils = HiveUtils();

  SearchSpecialistCubit(this._specialistRepository)
      : super(const SearchSpecialistState(status: SearchSpecialistStatus.init));

  Future<void> searchSpecialists(String keyword, int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isSearching) return null;
      final currentState = state;
      List<SpecialistDetails> oldSpecialists = [];
      List<SpecialistDetails> specialists = [];
      if (currentState.status.isSearchSuccess) {
        oldSpecialists = state.specialists;
      }
      emit(state.copyWith(
        status: SearchSpecialistStatus.searching,
        oldSpecialists: oldSpecialists,
        isFirstFetch: page == 0,
      ));
      var specialist = await _specialistRepository.getSpecialistByName(
          token: token, page: page, keyword: keyword);
      if (specialist == 204) {
        emit(state.copyWith(
            page: page,
            status: SearchSpecialistStatus.searchSuccess,
            specialists: oldSpecialists));
      } else {
        page++;
        var specialistDetails = await fetchSpecialistsById(specialist, token);
        final thisSpecialists = state.oldSpecialists;
        specialists.addAll(thisSpecialists);
        specialists.addAll(specialistDetails);
        emit(state.copyWith(
            page: page,
            status: SearchSpecialistStatus.searchSuccess,
            specialists: specialists));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: SearchSpecialistStatus.searchFailed, message: e.toString()));
    }
  }

  Future<List<SpecialistDetails>> fetchSpecialistsById(
      List<ListSpec> specialists, String token) async {
    List<SpecialistDetails> result = [];
    for (ListSpec spec in specialists) {
      SpecialistDetails specialistDetails = await _specialistRepository
          .getSpecialistInfo(token: token, specId: spec.specId);
      result.add(specialistDetails);
    }
    return result;
  }
}
