import 'package:dio/dio.dart';
import 'package:expat_assistant/src/models/payment.dart';
import 'package:flutter/material.dart';

class PaymentProvider {
  final Dio _dio = Dio();

  Future<dynamic> paymentRequest({@required Payment payment}) async {
    String url = 'https://test-payment.momo.vn/pay/app';
    Map<String, dynamic> headers = {
      Headers.contentTypeHeader: "application/json",
    };
    Response response = await _dio.post(url,
        options: Options(headers: headers), data: paymentToJson(payment));
    print(response);
  }
}
