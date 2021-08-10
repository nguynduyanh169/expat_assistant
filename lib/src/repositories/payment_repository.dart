import 'package:expat_assistant/src/models/payment.dart';
import 'package:expat_assistant/src/providers/payment_provider.dart';
import 'package:flutter/cupertino.dart';

class PaymentRepository {
  final PaymentProvider _paymentProvider = PaymentProvider();

  Future<dynamic> paymentRequest({@required Payment payment}) {
    return _paymentProvider.paymentRequest(payment: payment);
  }

  Future<dynamic> createPayment(
      {@required PaymentSave paymentSave, @required String token}) {
    return _paymentProvider.createPayment(
        paymentSave: paymentSave, token: token);
  }

  Future<dynamic> getPaymentsByExpatId(
      {@required String token, @required int expatId}) {
    return _paymentProvider.getPaymentsByExpatId(
        token: token, expatId: expatId);
  }

}
