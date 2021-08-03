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


// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

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

