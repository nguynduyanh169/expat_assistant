
import 'package:dio/dio.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/payment.dart';
import 'package:expat_assistant/src/models/payment_result.dart';
import 'package:flutter/material.dart';

class PaymentProvider {
  final Dio _dio = Dio();

  Future<dynamic> paymentRequest({@required Payment payment}) async {
    try {
      Map<String, dynamic> headers = {
        Headers.contentTypeHeader: "application/json",
      };
      Response response = await _dio.post(ApiName.MOMO_PAYMENT_API,
          options: Options(headers: headers), data: paymentToJson(payment));
      if (response.data["status"] == 0) {
        PaymentRespone paymentRespone = PaymentRespone.fromJson(response.data);
        return paymentRespone;
      } else {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response.data);
        print(errorResponse.message + errorResponse.status.toString());
        return errorResponse;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> createPayment(
      {@required PaymentSave paymentSave, @required String token}) async {
    PaymentResult result;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token'
      };
      Response response = await _dio.post(ApiName.CREATE_PAYMENT,
          options: Options(headers: headers), data: paymentSave.toJson());
      if (response.statusCode == 200) {
        result = PaymentResult.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<dynamic> getPaymentsByExpatId(
      {@required String token, @required int expatId}) async {
    List<PaymentView> paymentViews;
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "application/json",
        'Authorization': 'Bearer $token'
      };
      Response response = await _dio.get(
          ApiName.GET_PAYMENT_BY_EXPAT + "?expatId=$expatId",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        paymentViews = (response.data as List<dynamic>)
            .map((i) => PaymentView.fromJson(i))
            .toList()
            .cast<PaymentView>();
      }
    } catch (e) {
      print(e.toString());
    }
    return paymentViews;
  }
}
