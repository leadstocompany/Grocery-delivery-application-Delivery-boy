// To parse this JSON data, do
//
//     final vendorOtpModel = vendorOtpModelFromJson(jsonString);

import 'dart:convert';

VendorOtpModel vendorOtpModelFromJson(String str) =>
    VendorOtpModel.fromJson(json.decode(str));

String vendorOtpModelToJson(VendorOtpModel data) => json.encode(data.toJson());

class VendorOtpModel {
  String? message;
  Data? data;

  VendorOtpModel({
    this.message,
    this.data,
  });

  factory VendorOtpModel.fromJson(Map<String, dynamic> json) => VendorOtpModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  User? user;
  String? accessToken;
  String? refreshToken;

  Data({
    this.user,
    this.accessToken,
    this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}

class User {
  String? id;
  String? phone;
  bool? isPhoneVerified;

  User({
    this.id,
    this.phone,
    this.isPhoneVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        phone: json["phone"],
        isPhoneVerified: json["isPhoneVerified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "isPhoneVerified": isPhoneVerified,
      };
}
