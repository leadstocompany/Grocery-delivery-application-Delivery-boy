// To parse this JSON data, do
//
//     final deliveryOtpmodel = deliveryOtpmodelFromJson(jsonString);

import 'dart:convert';

DeliveryOtpmodel deliveryOtpmodelFromJson(String str) =>
    DeliveryOtpmodel.fromJson(json.decode(str));

String deliveryOtpmodelToJson(DeliveryOtpmodel data) =>
    json.encode(data.toJson());

class DeliveryOtpmodel {
  String? code;
  DateTime? expiresAt;

  DeliveryOtpmodel({
    this.code,
    this.expiresAt,
  });

  factory DeliveryOtpmodel.fromJson(Map<String, dynamic> json) =>
      DeliveryOtpmodel(
        code: json["code"],
        expiresAt: DateTime.parse(json["expiresAt"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "expiresAt": expiresAt!.toIso8601String(),
      };
}
