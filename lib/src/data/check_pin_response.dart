// To parse this JSON data, do
//
//     final checkPinResponse = checkPinResponseFromJson(jsondynamic);

import 'dart:convert';

CheckPinResponse checkPinResponseFromJson(dynamic str) =>
    CheckPinResponse.fromJson(json.decode(str));

dynamic checkPinResponseToJson(CheckPinResponse data) =>
    json.encode(data.toJson());

class CheckPinResponse {
  dynamic id;
  dynamic code;
  bool? isActive;
  bool? isManual;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isDeliverable;
  

  CheckPinResponse({
    this.id,
    this.code,
    this.isActive,
    this.isManual,
    this.createdAt,
    this.updatedAt,
    this.isDeliverable,
    
  });

  factory CheckPinResponse.fromJson(Map<dynamic, dynamic> json) =>
      CheckPinResponse(
        id: json["id"],
        code: json["code"],
        isActive: json["isActive"],
        isManual: json["isManual"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isDeliverable: json["isDeliverable"],
       
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "isActive": isActive,
        "isManual": isManual,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isDeliverable": isDeliverable,
      
      };
}
