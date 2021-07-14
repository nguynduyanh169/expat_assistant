import 'dart:collection';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/repositories/specialist_repository.dart';
import 'package:expat_assistant/src/states/specialis_details_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/utils/session_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialistDetailsCubit extends Cubit<SpecialistDetailState> {
  SpecialistRepository _specialistRepository;
  HiveUtils _hiveUtils = HiveUtils();
  SessionUtils _sessionUtils = SessionUtils();

  SpecialistDetailsCubit(this._specialistRepository)
      : super(const SpecialistDetailState(status: SpecialistDetailStatus.init));

  Future<void> getSpecialistDetails(int specId) async {
    emit(state.copyWith(status: SpecialistDetailStatus.loadingDetails));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      SpecialistDetails specialistDetails = await _specialistRepository
          .getSpecialistInfo(token: token, specId: specId);
      if (specialistDetails == null) {
        emit(state.copyWith(
            status: SpecialistDetailStatus.loadDetailsFailed,
            message: 'Cannot load Specialist Infomation'));
      } else {
        List<SessionDisplay> sessionDisplays =
            _sessionUtils.addSession(sessions: specialistDetails.sessions);
        LinkedHashMap<DateTime, List<SessionDisplay>> sessionsForCalendar =
            _sessionUtils.getSessiontToCalendar(sessionLists: sessionDisplays);
        emit(state.copyWith(
            status: SpecialistDetailStatus.loadedDetails,
            specialistDetails: specialistDetails,
            sessions: sessionsForCalendar));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: SpecialistDetailStatus.loadDetailsFailed,
          message: e.toString()));
    }
  }
}
