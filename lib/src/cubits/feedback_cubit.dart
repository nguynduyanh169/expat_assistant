import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/feedback_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  AppointmentRepository _appointmentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  FeedbackCubit(this._appointmentRepository)
      : super(const FeedbackState(status: FeedbackStatus.init));

  Future<void> initializeFeedback(int appointmentId) async {
    emit(state.copyWith(status: FeedbackStatus.loading));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      ExpatAppointment appointment =
          await _appointmentRepository.feedbackAppointment(
              token: token,
              rating: 0,
              comment: '',
              appointmentId: appointmentId);
      if(appointment == null){
        emit(state.copyWith(
          status: FeedbackStatus.loading, message: 'An error occur while loading screen'));
      }else{
        emit(state.copyWith(
          status: FeedbackStatus.loaded));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FeedbackStatus.loadError, message: e.toString()));
    }
  }

  Future<void> feedBack(String comment, int appointmentId, double rating) async{
    emit(state.copyWith(status: FeedbackStatus.feedbacking));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      ExpatAppointment appointment =
          await _appointmentRepository.feedbackAppointment(
              token: token,
              rating: rating,
              comment: comment,
              appointmentId: appointmentId);
      if(appointment == null){
        emit(state.copyWith(
          status: FeedbackStatus.feedBackError, message: 'An error occur while feedback'));
      }else{
        emit(state.copyWith(
          status: FeedbackStatus.feedbackCompleted));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FeedbackStatus.feedBackError, message: e.toString()));
    }
  }
}
