// To parse this JSON data, do
//
//     final momoRefundDetails = momoRefundDetailsFromJson(jsonString);

import 'dart:convert';

MomoRefundDetails momoRefundDetailsFromJson(String str) => MomoRefundDetails.fromJson(json.decode(str));

String momoRefundDetailsToJson(MomoRefundDetails data) => json.encode(data.toJson());

class MomoRefundDetails {
    MomoRefundDetails({
        this.partnerCode,
        this.partnerRefId,
        this.momoTransId,
        this.amount,
    });

    String partnerCode;
    String partnerRefId;
    String momoTransId;
    int amount;

    factory MomoRefundDetails.fromJson(Map<String, dynamic> json) => MomoRefundDetails(
        partnerCode: json["partnerCode"],
        partnerRefId: json["partnerRefId"],
        momoTransId: json["momoTransId"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "partnerRefId": partnerRefId,
        "momoTransId": momoTransId,
        "amount": amount,
    };
}

