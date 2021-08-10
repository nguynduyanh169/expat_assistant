// To parse this JSON data, do
//
//     final sessionForPayment = sessionForPaymentFromJson(jsonString);

import 'dart:convert';

import 'package:expat_assistant/src/models/appointment.dart';

import 'expat.dart';

PaymentResult sessionForPaymentFromJson(String str) =>
    PaymentResult.fromJson(json.decode(str));

String sessionForPaymentToJson(PaymentResult data) =>
    json.encode(data.toJson());

class PaymentResult {
  PaymentResult({
    this.paymentId,
    this.expat,
    this.consultantAppoinment,
    this.amount,
    this.createDate,
    this.transactionCode,
    this.paymentMethod,
  });

  int paymentId;
  ExpatPaymentResult expat;
  ConsultantAppoinmentPaymentResult consultantAppoinment;
  double amount;
  List<int> createDate;
  String transactionCode;
  String paymentMethod;

  factory PaymentResult.fromJson(Map<String, dynamic> json) => PaymentResult(
        paymentId: json["paymentId"],
        expat: ExpatPaymentResult.fromJson(json["expat"]),
        consultantAppoinment: ConsultantAppoinmentPaymentResult.fromJson(
            json["consultantAppoinment"]),
        amount: json["amount"],
        createDate: List<int>.from(json["createDate"].map((x) => x)),
        transactionCode: json["transactionCode"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "expat": expat.toJson(),
        "consultantAppoinment": consultantAppoinment.toJson(),
        "amount": amount,
        "createDate": List<dynamic>.from(createDate.map((x) => x)),
        "transactionCode": transactionCode,
        "paymentMethod": paymentMethod,
      };
}

class ConsultantAppoinmentPaymentResult {
  ConsultantAppoinmentPaymentResult({
    this.conAppId,
    this.session,
  });

  int conAppId;
  SessionPaymentResult session;

  factory ConsultantAppoinmentPaymentResult.fromJson(
          Map<String, dynamic> json) =>
      ConsultantAppoinmentPaymentResult(
        conAppId: json["conAppId"],
        session: SessionPaymentResult.fromJson(json["session"]),
      );

  Map<String, dynamic> toJson() => {
        "conAppId": conAppId,
        "session": session.toJson(),
      };
}

class SessionPaymentResult {
  SessionPaymentResult({
    this.consultId,
  });

  int consultId;

  factory SessionPaymentResult.fromJson(Map<String, dynamic> json) =>
      SessionPaymentResult(
        consultId: json["consultId"],
      );

  Map<String, dynamic> toJson() => {
        "consultId": consultId,
      };
}

class ExpatPaymentResult {
  ExpatPaymentResult({
    this.id,
  });

  int id;

  factory ExpatPaymentResult.fromJson(Map<String, dynamic> json) =>
      ExpatPaymentResult(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

PaymentView paymentViewFromJson(String str) =>
    PaymentView.fromJson(json.decode(str));

class PaymentView {
  PaymentView({
    this.paymentId,
    this.expat,
    this.consultantAppoinment,
    this.amount,
    this.createDate,
    this.transactionCode,
    this.paymentMethod,
  });

  int paymentId;
  ExpatPaymentResult expat;
  ConsultantAppoinmentPaymentResult consultantAppoinment;
  double amount;
  List<int> createDate;
  String transactionCode;
  String paymentMethod;

  factory PaymentView.fromJson(Map<String, dynamic> json) => PaymentView(
        paymentId: json["paymentId"],
        expat: ExpatPaymentResult.fromJson(json["expat"]),
        consultantAppoinment: ConsultantAppoinmentPaymentResult.fromJson(
            json["consultantAppoinment"]),
        amount: json["amount"],
        createDate: List<int>.from(json["createDate"].map((x) => x)),
        transactionCode: json["transactionCode"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "expat": expat.toJson(),
        "consultantAppoinment": consultantAppoinment.toJson(),
        "amount": amount,
        "createDate": List<dynamic>.from(createDate.map((x) => x)),
        "transactionCode": transactionCode,
        "paymentMethod": paymentMethod,
      };
}
