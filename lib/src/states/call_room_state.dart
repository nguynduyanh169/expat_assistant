import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/appointment.dart';

class CallRoomState extends Equatable {
  final String message;
  final CallRoomStatus status;
  final int seconds;
  final ExpatAppointment appointment;

  const CallRoomState(
      {this.appointment, this.message, this.status, this.seconds});

  @override
  // TODO: implement props
  List<Object> get props => [message, status, appointment, seconds];

  CallRoomState copyWith(
      {String message,
      CallRoomStatus status,
      ExpatAppointment appointment,
      int seconds}) {
    return CallRoomState(
        message: message ?? this.message,
        status: status ?? this.status,
        appointment: appointment ?? this.appointment,
        seconds: seconds ?? this.seconds);
  }
}

enum CallRoomStatus { init, loadingRoom, loadedRoom, loadRoomError }

extension Explaination on CallRoomStatus {
  bool get isLoadingRoom => this == CallRoomStatus.loadingRoom;
  bool get isLoadedRoom => this == CallRoomStatus.loadedRoom;
  bool get isLoadRoomError => this == CallRoomStatus.loadRoomError;
  bool get isInit => this == CallRoomStatus.init;
}
