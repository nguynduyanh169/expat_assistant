import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/room_call.dart';

class CallRoomState extends Equatable {
  final String message;
  final CallRoomStatus status;
  final int seconds;
  final ExpatAppointment appointment;
  final RoomCall roomCall;

  const CallRoomState(
      {this.appointment,
      this.message,
      this.status,
      this.seconds,
      this.roomCall});

  @override
  // TODO: implement props
  List<Object> get props => [message, status, appointment, seconds, roomCall];

  CallRoomState copyWith(
      {String message,
      CallRoomStatus status,
      ExpatAppointment appointment,
      int seconds,
      RoomCall roomCall}) {
    return CallRoomState(
        message: message ?? this.message,
        status: status ?? this.status,
        appointment: appointment ?? this.appointment,
        seconds: seconds ?? this.seconds,
        roomCall: roomCall ?? this.roomCall);
  }
}

enum CallRoomStatus {
  init,
  loadingRoom,
  loadedRoom,
  loadRoomError,
  notInTime,
  outOfDate,
  appointmentCompleted
}

extension Explaination on CallRoomStatus {
  bool get isLoadingRoom => this == CallRoomStatus.loadingRoom;
  bool get isLoadedRoom => this == CallRoomStatus.loadedRoom;
  bool get isLoadRoomError => this == CallRoomStatus.loadRoomError;
  bool get isInit => this == CallRoomStatus.init;
  bool get isNotInTime => this == CallRoomStatus.notInTime;
  bool get isAppointmentCompleted =>
      this == CallRoomStatus.appointmentCompleted;
  bool get isOutOfDate =>
      this == CallRoomStatus.outOfDate;
}
