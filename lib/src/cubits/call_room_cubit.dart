import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/call_room_state.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallRoomCubit extends Cubit<CallRoomState> {
  AppointmentRepository _appointmentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  DateTimeUtils _dateTimeUtils = DateTimeUtils();
  CallRoomCubit(this._appointmentRepository)
      : super(const CallRoomState(status: CallRoomStatus.init));

  Future<void> getAppointmentById(int appointmentId) async {
    emit(state.copyWith(status: CallRoomStatus.loadingRoom));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      Appointment appointment = await _appointmentRepository
          .getAppointmentsById(token: token, appointmentId: appointmentId);
      if (appointment == null) {
        emit(state.copyWith(
            status: CallRoomStatus.loadRoomError,
            message: 'An error occurs while loading appoinment.'));
      } else {
        int duration = _dateTimeUtils.caculateDuration(
            appointment.session.startTime, appointment.session.endTime);
        emit(state.copyWith(
            status: CallRoomStatus.loadedRoom, appointment: appointment, seconds: duration));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: CallRoomStatus.loadRoomError, message: e.toString()));
    }
  }
}
