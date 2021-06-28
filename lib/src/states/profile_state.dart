import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String message;
  final ProfileStatus status;

  const ProfileState({this.message, this.status});

  @override
  // TODO: implement props
  List<Object> get props => [message, status];

  ProfileState copyWith({String message, ProfileStatus status}) {
    return ProfileState(message: message ?? this.message, status: status ?? this.status);
  }
}

enum ProfileStatus {
  logoutSuccess,
  loggingOut,
  logoutFailed,
}

extension Explanation on ProfileStatus {
  bool get isLogoutSuccess => this == ProfileStatus.logoutSuccess;

  bool get isLoggingOut => this == ProfileStatus.loggingOut;

  bool get isLogoutFailed => this == ProfileStatus.logoutFailed;
}
