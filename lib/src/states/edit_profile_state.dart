import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/expat.dart';

class EditProfileState extends Equatable {
  final Profile expatProfile;
  final EditProfileStatus status;
  final String message;

  const EditProfileState({this.expatProfile, this.status, this.message});

  @override
  // TODO: implement props
  List<Object> get props => [expatProfile, status, message];

  EditProfileState copyWith(
      {Profile expatProfile, EditProfileStatus status, String message}) {
    return EditProfileState(
        expatProfile: expatProfile ?? this.expatProfile,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}

enum EditProfileStatus {
  init,
  loadingProfile,
  loadedProfile,
  loadProfileFailed,
  updatingProfile,
  updatedProfile,
  updateProfileFailed
}

extension Explaination on EditProfileStatus {
  bool get isInit => this == EditProfileStatus.init;
  bool get isLoadingProfile => this == EditProfileStatus.loadingProfile;
  bool get isLoadedProfile => this == EditProfileStatus.loadedProfile;
  bool get isLoadProfileFailed => this == EditProfileStatus.loadProfileFailed;
  bool get isUpdatingProfile => this == EditProfileStatus.updatingProfile;
  bool get isUpdatedProfile => this == EditProfileStatus.updatedProfile;
  bool get isUpdateProfileFailed => this == EditProfileStatus.updatedProfile;
}
