// To parse this JSON data, do
//
//     final UserResponse = UserResponseFromJson(jsondynamic);

import 'dart:convert';
// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsondynamic);

import 'dart:convert';

UserResponse userResponseFromJson(dynamic str) =>
    UserResponse.fromJson(json.decode(str));

dynamic userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  dynamic id;
  dynamic phone;
  dynamic email;
  dynamic firstName;
  dynamic lastName;
  dynamic name;
  dynamic role;
  bool? isPhoneVerified;
  dynamic img;
  dynamic storeId;
  dynamic currentStatus;
   bool? address;

  UserResponse({
    this.id,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.name,
    this.role,
    this.isPhoneVerified,
    this.img,
    this.storeId,
      this.address,
    this.currentStatus,
  });

  factory UserResponse.fromJson(Map<dynamic, dynamic> json) => UserResponse(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        name: json["name"],
        role: json["role"],
        isPhoneVerified: json["isPhoneVerified"],
        img: json["img"],
        storeId: json["storeId"],
         address: json["address"],
        currentStatus: json["currentStatus"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
        "role": role,
        "isPhoneVerified": isPhoneVerified,
        "img": img,
        "storeId": storeId,
           "address": address,
        "currentStatus": currentStatus,
      };
}
