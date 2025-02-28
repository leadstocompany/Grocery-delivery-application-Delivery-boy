// To parse this JSON data, do
//
//     final UserResponse = UserResponseFromJson(jsondynamic);

import 'dart:convert';

UserResponse UserResponseFromJson(dynamic str) => UserResponse.fromJson(json.decode(str));

dynamic UserResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    dynamic id;
    dynamic phone;
    dynamic firstName;
    dynamic lastName;
    dynamic name;
    dynamic role;
    bool? isPhoneVerified;
    dynamic storeId;

    UserResponse({
        this.id,
        this.phone,
        this.firstName,
        this.lastName,
        this.name,
        this.role,
        this.isPhoneVerified,
        this.storeId,
    });

    factory UserResponse.fromJson(Map<dynamic, dynamic> json) => UserResponse(
        id: json["id"],
        phone: json["phone"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        name: json["name"],
        role: json["role"],
        isPhoneVerified: json["isPhoneVerified"],
        storeId: json["storeId"],
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
        "role": role,
        "isPhoneVerified": isPhoneVerified,
        "storeId": storeId,
    };
}
