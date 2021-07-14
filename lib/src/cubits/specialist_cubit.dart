import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/states/specialists_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/material.dart';

class SpecialistCubit extends Cubit<SpecialistState> {
  SpecialistRepository _specialistRepository;
  HiveUtils _hiveUtils = HiveUtils();

  SpecialistCubit(this._specialistRepository)
      : super(const SpecialistState(status: SpecialistStatus.init));

  Future<void> getSpecialists(int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingSpecialist) return null;
      final currentState = state;
      List<ListSpec> oldSpecialists = [];
      List<ListSpec> specialists = [];
      if (currentState.status.isLoadedSpecialist) {
        oldSpecialists = state.specialists;
      }
      emit(state.copyWith(
        status: SpecialistStatus.loadingSpecialist,
        oldSpecialists: oldSpecialists,
        isFirstFetch: page == 0,
      ));
      var specialist = await _specialistRepository.getSpecialistsByRating(
          token: token, page: page);
      if (specialist == 204) {
        emit(state.copyWith(
            page: page,
            status: SpecialistStatus.loadedSpecialist,
            specialists: oldSpecialists));
      } else {
        page++;
        final thisSpecialists = state.oldSpecialists;
        specialists.addAll(thisSpecialists);
        specialists.addAll(specialist);

        emit(state.copyWith(
            page: page,
            status: SpecialistStatus.loadedSpecialist,
            specialists: specialists));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: SpecialistStatus.loadSpecialistError));
    }
  }
}
