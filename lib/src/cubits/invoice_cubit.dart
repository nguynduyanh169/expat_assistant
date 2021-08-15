import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/models/payment.dart';
import 'package:expat_assistant/src/models/payment_result.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/repositories/payment_repository.dart';
import 'package:expat_assistant/src/states/invoice_state.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/utils/notification_utils.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  AppointmentRepository _appointmentRepository;
  PaymentRepository _paymentRepository;
  HiveUtils _hiveUtils = HiveUtils();
  InvoiceCubit(this._appointmentRepository, this._paymentRepository)
      : super(const InvoiceState(status: InvoiceStatus.init));

  Future<void> registrySessions(SessionDisplay session,
      PaymentRespone paymentRespone, String channelName) async {
    print(channelName);
    emit(state.copyWith(status: InvoiceStatus.registrying));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      int expatId = loginResponse['id'];
      ExpatAppointment appointment =
          await _appointmentRepository.registrySession(
              token: token,
              expatId: expatId,
              sessionId: session.sessionId,
              channelName: channelName);
      if (appointment == null) {
        emit(state.copyWith(
            status: InvoiceStatus.registryFailed,
            message: "An error occur while registry session"));
      } else {
        ExpatForPayment expat = ExpatForPayment(id: expatId);
        SessionForPayment session =
            SessionForPayment(consultId: appointment.session.consultId);
        ConsultantAppoinmentForPayment consultantAppoinment =
            ConsultantAppoinmentForPayment(
                conAppId: appointment.conAppId, session: session);
        PaymentSave paymentSave = PaymentSave(
            amount: paymentRespone.amount.toDouble(),
            consultantAppoinment: consultantAppoinment,
            expat: expat,
            paymentMethod: 'Momo Wallet',
            createDate: DateTime.now(),
            transactionCode: paymentRespone.transid);
        PaymentResult result = await _paymentRepository.createPayment(
            paymentSave: paymentSave, token: token);
        if (result == null) {
          emit(state.copyWith(
              status: InvoiceStatus.registryFailed,
              message: "An error occur while registry session"));
        } else {
          NotificationUtils.pushNotification(
              'Register Appointment ${DateTimeUtils.getAppointmentDate(startDateTime: appointment.session.startTime)}',
              'You have registered an appointment with ${appointment.session.specialist.fullname} at ${DateTimeUtils.getAppointmentDate(startDateTime: appointment.session.startTime)} successfully');
          NotificationUtils.pushScheduleNotificaton(
                                  'Upcoming Appointment ${DateTimeUtils.getAppointmentDate(startDateTime: appointment.session.startTime)}',
                                  'There is an appointment with ${appointment.session.specialist.fullname} at ${DateTimeUtils.getAppointmentDate(startDateTime: appointment.session.startTime)}',
                                  DateTime(appointment.session.startTime[0], appointment.session.startTime[1], appointment.session.startTime[2], appointment.session.startTime[3], appointment.session.startTime[4]).toUtc());
          emit(state.copyWith(status: InvoiceStatus.registrySuccess));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: InvoiceStatus.registryFailed, message: e.toString()));
    }
  }

  Future<void> paymentWithMomo(Payment payment) async {
    emit(state.copyWith(status: InvoiceStatus.payingWithMomo));
    try {
      var result = await _paymentRepository.paymentRequest(payment: payment);
      if (result.runtimeType == PaymentRespone) {
        emit(state.copyWith(
            status: InvoiceStatus.payWithMomoSuccess, paymentRespone: result));
      } else {
        emit(state.copyWith(
            status: InvoiceStatus.payWithMomoFailed,
            message: 'An error occur while executing payment with Momo'));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: InvoiceStatus.payWithMomoFailed, message: e.toString()));
    }
  }
}
