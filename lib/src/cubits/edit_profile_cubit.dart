import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/edit_profile_state.dart';
import 'package:expat_assistant/src/utils/firebase_utils.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  UserRepository _userRepository;
  HiveUtils _hiveUtils = HiveUtils();
  EditProfileCubit(this._userRepository)
      : super(const EditProfileState(status: EditProfileStatus.init));

  Future<void> getProfile() async {
    emit(state.copyWith(status: EditProfileStatus.loadingProfile));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      String email = loginResponse['email'].toString();
      Profile profile =
          await _userRepository.getExpatProfile(token: token, email: email);
      if (profile == null) {
        emit(state.copyWith(
            status: EditProfileStatus.loadProfileFailed,
            message: "Cannot get profile!"));
      } else {
        emit(state.copyWith(
            status: EditProfileStatus.loadedProfile, expatProfile: profile));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: EditProfileStatus.loadProfileFailed, message: e.toString()));
    }
  }

  Future<void> editProfile(File image, Profile profile) async {
    emit(state.copyWith(status: EditProfileStatus.updatingProfile));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      String password = loginResponse['password'].toString();
      if (image == null) {
        String fullname = profile.expat.fullname;
        String phone = profile.expat.phone;
        String email = profile.expat.email;
        String nation = profile.expat.nationEntity.nationName;
        List<Language> languages = profile.languages;
        String avatarLink = profile.expat.avatarLink;
        Expat expat = Expat(
            avataLink: avatarLink,
            email: email,
            fullname: fullname,
            phone: phone,
            password: password,
            nationEntity: nation,
            languages: languages);
        ExpatProfile expatProfile = await _userRepository.editExpatProfile(
            token: token, expatId: profile.expat.id, expat: expat);
        if (expatProfile == null) {
          emit(state.copyWith(
              status: EditProfileStatus.updateProfileFailed,
              message: "An error occured while updating infomation!"));
        } else {
          _hiveUtils.editUserAuth(
              boxName: HiveBoxName.USER_AUTH,
              fullname: fullname,
              avatar: avatarLink);
          emit(state.copyWith(status: EditProfileStatus.updatedProfile));
        }
      } else {
        String avatarLink = await FirebaseUtils.uploadImage(
            image: image, folderName: "expat/${profile.expat.id}");
        print(avatarLink);
        if (avatarLink == null || avatarLink.length == 0) {
          emit(state.copyWith(
              status: EditProfileStatus.updateProfileFailed,
              message: "An error occured while updating infomation!"));
        } else {
          String fullname = profile.expat.fullname;
          String phone = profile.expat.phone;
          String email = profile.expat.email;
          String nation = profile.expat.nationEntity.nationName;
          List<Language> languages = profile.languages;
          Expat expat = Expat(
              avataLink: avatarLink,
              email: email,
              fullname: fullname,
              password: password,
              phone: phone,
              nationEntity: nation,
              languages: languages);
          ExpatProfile expatProfile = await _userRepository.editExpatProfile(
              token: token, expatId: profile.expat.id, expat: expat);
          if (expatProfile == null) {
            emit(state.copyWith(
                status: EditProfileStatus.updateProfileFailed,
                message: "An error occured while updating infomation!"));
          } else {
            _hiveUtils.editUserAuth(
                boxName: HiveBoxName.USER_AUTH,
                fullname: fullname,
                avatar: avatarLink);
            emit(state.copyWith(status: EditProfileStatus.updatedProfile));
          }
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: EditProfileStatus.updateProfileFailed,
          message: e.toString()));
    }
  }
}
