// To parse this JSON data, do
//
//     final paymentRequest = paymentRequestFromJson(jsonString);

import 'dart:convert';

PaymentRequest paymentRequestFromJson(String str) =>
    PaymentRequest.fromJson(json.decode(str));

String paymentRequestToJson(PaymentRequest data) => json.encode(data.toJson());

class PaymentRequest {
  PaymentRequest({
    this.partnerCode,
    this.partnerRefId,
    this.partnerTransId,
    this.amount,
  });

  String partnerCode;
  String partnerRefId;
  String partnerTransId;
  int amount;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
        partnerCode: json["partnerCode"],
        partnerRefId: json["partnerRefId"],
        partnerTransId: json["partnerTransId"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "partnerRefId": partnerRefId,
        "partnerTransId": partnerTransId,
        "amount": amount,
      };
}

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    this.customerNumber,
    this.partnerCode,
    this.partnerRefId,
    this.appData,
    this.hash,
    this.description,
    this.version,
  });

  String customerNumber;
  String partnerCode;
  String partnerRefId;
  String appData;
  String hash;
  String description;
  int version;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        customerNumber: json["customerNumber"],
        partnerCode: json["partnerCode"],
        partnerRefId: json["partnerRefId"],
        appData: json["appData"],
        hash: json["hash"],
        description: json["description"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "customerNumber": customerNumber,
        "partnerCode": partnerCode,
        "partnerRefId": partnerRefId,
        "appData": appData,
        "hash": hash,
        "description": description,
        "version": version,
      };
}

PaymentRespone paymentResponeFromJson(String str) =>
    PaymentRespone.fromJson(json.decode(str));

String paymentResponeToJson(PaymentRespone data) => json.encode(data.toJson());

class PaymentRespone {
  PaymentRespone({
    this.status,
    this.message,
    this.amount,
    this.transid,
    this.signature,
  });

  int status;
  String message;
  int amount;
  String transid;
  String signature;

  factory PaymentRespone.fromJson(Map<String, dynamic> json) => PaymentRespone(
        status: json["status"],
        message: json["message"],
        amount: json["amount"],
        transid: json["transid"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "amount": amount,
        "transid": transid,
        "signature": signature,
      };
}

class PaymentSave {
  PaymentSave({
    this.amount,
    this.consultantAppoinment,
    this.createDate,
    this.expat,
    this.paymentId,
    this.paymentMethod,
    this.transactionCode,
  });

  double amount;
  ConsultantAppoinmentForPayment consultantAppoinment;
  DateTime createDate;
  ExpatForPayment expat;
  int paymentId;
  String paymentMethod;
  String transactionCode;

  factory PaymentSave.fromJson(Map<String, dynamic> json) => PaymentSave(
        amount: json["amount"],
        consultantAppoinment: ConsultantAppoinmentForPayment.fromJson(
            json["consultantAppoinment"]),
        createDate: DateTime.parse(json["createDate"]),
        expat: ExpatForPayment.fromJson(json["expat"]),
        paymentId: json["paymentId"],
        paymentMethod: json["paymentMethod"],
        transactionCode: json["transactionCode"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "consultantAppoinment": consultantAppoinment.toJson(),
        "createDate": createDate.toIso8601String(),
        "expat": expat.toJson(),
        "paymentId": paymentId,
        "paymentMethod": paymentMethod,
        "transactionCode": transactionCode,
      };
}

class ConsultantAppoinmentForPayment {
  ConsultantAppoinmentForPayment({this.conAppId, this.session});

  int conAppId;
  SessionForPayment session;

  factory ConsultantAppoinmentForPayment.fromJson(Map<String, dynamic> json) =>
      ConsultantAppoinmentForPayment(
          conAppId: json["conAppId"],
          session: SessionForPayment.fromJson(json["session"]));

  Map<String, dynamic> toJson() =>
      {"conAppId": conAppId, "session": session.toJson()};
}

class ExpatForPayment {
  ExpatForPayment({
    this.id,
  });

  int id;
  factory ExpatForPayment.fromJson(Map<String, dynamic> json) =>
      ExpatForPayment(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class SessionForPayment {
  SessionForPayment({
    this.consultId,
  });

  int consultId;

  factory SessionForPayment.fromJson(Map<String, dynamic> json) =>
      SessionForPayment(
        consultId: json["consultId"],
      );

  Map<String, dynamic> toJson() => {
        "consultId": consultId,
      };
}

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

class TotalPaymentsMonth {
  double total;
  int month;
  TotalPaymentsMonth({this.month, this.total});
}
