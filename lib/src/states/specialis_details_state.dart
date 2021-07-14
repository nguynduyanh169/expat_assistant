import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/models/specialist.dart';

class SpecialistDetailState extends Equatable {
  final SpecialistDetails specialistDetails;
  final SpecialistDetailStatus status;
  final String message;
  final LinkedHashMap<DateTime, List<SessionDisplay>> sessions;

  const SpecialistDetailState(
      {this.specialistDetails, this.message, this.status, this.sessions});

  @override
  // TODO: implement props
  List<Object> get props => [specialistDetails, message, status, sessions];

  SpecialistDetailState copyWith(
      {SpecialistDetails specialistDetails,
      SpecialistDetailStatus status,
      String message,
      LinkedHashMap<DateTime, List<SessionDisplay>> sessions}) {
    return SpecialistDetailState(
        specialistDetails: specialistDetails ?? this.specialistDetails,
        status: status ?? this.status,
        message: message ?? this.message,
        sessions: sessions ?? this.sessions);
  }
}

enum SpecialistDetailStatus {
  init,
  loadingDetails,
  loadedDetails,
  loadDetailsFailed
}

extension Explaination on SpecialistDetailStatus {
  bool get isInit => this == SpecialistDetailStatus.init;

  bool get isLoadingSpecialistDetail =>
      this == SpecialistDetailStatus.loadingDetails;

  bool get isLoadedSpecialistDetail =>
      this == SpecialistDetailStatus.loadedDetails;

  bool get isLoadSpecialistDetailError =>
      this == SpecialistDetailStatus.loadDetailsFailed;
}
