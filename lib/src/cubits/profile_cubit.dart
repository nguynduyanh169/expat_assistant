import 'dart:io';

import 'package:android_external_storage/android_external_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/states/profile_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  HiveUtils _hiveUtils = HiveUtils();

  Future<void> logout() async {
    emit(state.copyWith(status: ProfileStatus.loggingOut));
    try {
      _hiveUtils.deleteAllLesson(boxName: HiveBoxName.CONVERSATION);
      _hiveUtils.deleteAllLesson(boxName: HiveBoxName.VOCABULARY);
      _hiveUtils.deleteAllLesson(boxName: HiveBoxName.LESSON_SRC);
      _hiveUtils.deleteUserAuth(boxName: HiveBoxName.USER_AUTH);
      List<LessonLocal> lessons =
          _hiveUtils.getAllLesson(boxName: HiveBoxName.LESSON);
      var path = await AndroidExternalStorage.getExternalStoragePublicDirectory(
          DirType.documentsDirectory);
      for (LessonLocal lesson in lessons) {
        String filePath = '$path/${lesson.name}';
        final dir = Directory(filePath);
        dir.deleteSync(recursive: true);
      }
      _hiveUtils.deleteAllLesson(boxName: HiveBoxName.LESSON);
      bool checkLogout = _hiveUtils.haveToken(boxName: HiveBoxName.USER_AUTH);
      if (checkLogout == false) {
        await FirebaseAuth.instance.signOut();
        emit(state.copyWith(status: ProfileStatus.logoutSuccess));
      } else {
        emit(state.copyWith(
            status: ProfileStatus.logoutFailed, message: 'Logout Failed'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: ProfileStatus.logoutFailed, message: e.toString()));
    }
  }
}
