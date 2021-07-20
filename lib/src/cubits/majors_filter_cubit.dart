import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/major.dart';
import 'package:expat_assistant/src/repositories/major_repository.dart';
import 'package:expat_assistant/src/states/majors_filter_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class MajorFilterCubit extends Cubit<MajorFilterState> {
  MajorRepository _majorRepository;
  HiveUtils _hiveUtils = HiveUtils();
  MajorFilterCubit(this._majorRepository)
      : super(const MajorFilterState(status: MajorFilterStatus.init));

  Future<void> getMajors(int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingMajors) return null;
      final currentState = state;
      List<Content> oldMajors = [];
      List<Content> majors = [];
      if (currentState.status.isLoadedMajors) {
        oldMajors = state.majors;
      }
      emit(state.copyWith(
        status: MajorFilterStatus.loadingMajors,
        oldMajors: oldMajors,
        isFirstFetch: page == 0,
      ));
      var major = await _majorRepository.getMajors(token: token, page: page);
      if (major == 204) {
        emit(state.copyWith(
            page: page,
            status: MajorFilterStatus.loadedMajors,
            majors: oldMajors));
      } else {
        page++;
        final thisMajors = state.oldMajors;
        majors.addAll(thisMajors);
        majors.addAll(major);
        print('success');
        emit(state.copyWith(
            page: page,
            status: MajorFilterStatus.loadedMajors,
            majors: majors));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: MajorFilterStatus.loadedMajors));
    }
  }
}
