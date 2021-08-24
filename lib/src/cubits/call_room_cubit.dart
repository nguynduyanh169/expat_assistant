import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/room_call.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/call_room_state.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/utils/text_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class CallRoomCubit extends Cubit<CallRoomState> {
  AppointmentRepository _appointmentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  DateTimeUtils _dateTimeUtils = DateTimeUtils();
  CallRoomCubit(this._appointmentRepository)
      : super(const CallRoomState(status: CallRoomStatus.init));

  Future<void> getAppointmentById(int appointmentId) async {
    emit(state.copyWith(status: CallRoomStatus.loadingRoom));
    try {
      var permissionStatus = await Permission.microphone.status;
      if (permissionStatus.isDenied) {
        permissionStatus = await Permission.microphone.request();
        if (!permissionStatus.isGranted) {
          return;
        }
      }
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      ExpatAppointment appointment = await _appointmentRepository
          .getAppointmentsById(token: token, appointmentId: appointmentId);
      if (appointment == null) {
        emit(state.copyWith(
            status: CallRoomStatus.loadRoomError,
            message: 'An error occurs while loading appoinment.'));
      } else {
        int status = _dateTimeUtils.equalsStartTime(appointment);
        if (status == 1) {
          emit(state.copyWith(
              status: CallRoomStatus.notInTime, appointment: appointment));
        } else if (status == 2) {
          emit(state.copyWith(
              status: CallRoomStatus.appointmentCompleted,
              appointment: appointment));
        } else if (status == -1) {
          emit(state.copyWith(
              status: CallRoomStatus.outOfDate, appointment: appointment));
        } else {
          int duration = _dateTimeUtils.caculateDuration(
              appointment.session.startTime, appointment.session.endTime);
          RoomCall roomCall =
              RoomCall(uid: int.parse(TextUtils.getUid()), role: 1);
          String agoraToken = await _appointmentRepository.generateToken(
              uid: roomCall.uid,
              channelName: appointment.channelName,
              token: token,
              expiredTime: 7200,
              role: 1);
          roomCall.token = agoraToken;
          emit(state.copyWith(
              status: CallRoomStatus.loadedRoom,
              appointment: appointment,
              seconds: duration,
              roomCall: roomCall));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: CallRoomStatus.loadRoomError, message: e.toString()));
    }
  }
}
