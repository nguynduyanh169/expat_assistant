import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/specialist.dart';

enum SpecialistStatus {
  init,
  loadingSpecialist,
  loadedSpecialist,
  loadSpecialistError
}

extension Explaination on SpecialistStatus {
  bool get isInit => this == SpecialistStatus.init;

  bool get isLoadingSpecialist => this == SpecialistStatus.loadingSpecialist;

  bool get isLoadedSpecialist => this == SpecialistStatus.loadedSpecialist;

  bool get isLoadSpecialistError =>
      this == SpecialistStatus.loadSpecialistError;
}

class SpecialistState extends Equatable {
  final List<SpecialistDetails> specialists;
  final List<SpecialistDetails> oldSpecialists;
  final ExpatAppointment todayAppointment;
  final int page;
  final SpecialistStatus status;
  final bool isFirstFetch;

  const SpecialistState(
      {this.specialists,
      this.oldSpecialists,
      this.page,
      this.status,
      this.isFirstFetch,
      this.todayAppointment});
  @override
  // TODO: implement props
  List<Object> get props => [
        specialists,
        oldSpecialists,
        page,
        status,
        isFirstFetch,
        todayAppointment
      ];

  SpecialistState copyWith(
      {List<SpecialistDetails> specialists,
      List<SpecialistDetails> oldSpecialists,
      int page,
      SpecialistStatus status,
      bool isFirstFetch,
      ExpatAppointment todayAppointment}) {
    return SpecialistState(
        specialists: specialists ?? this.specialists,
        oldSpecialists: oldSpecialists ?? this.oldSpecialists,
        page: page ?? this.page,
        status: status ?? this.status,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch,
        todayAppointment: todayAppointment ?? this.todayAppointment);
  }
}
