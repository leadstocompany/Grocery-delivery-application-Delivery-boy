// To parse this JSON data, do
//
//     final statusResponse = statusResponseFromJson(jsonString);

import 'dart:convert';

StatusResponse statusResponseFromJson(String str) => StatusResponse.fromJson(json.decode(str));

String statusResponseToJson(StatusResponse data) => json.encode(data.toJson());

class StatusResponse {
    String? message;
    String ?currentStatus;

    StatusResponse({
        this.message,
        this.currentStatus,
    });

    factory StatusResponse.fromJson(Map<String, dynamic> json) => StatusResponse(
        message: json["message"],
        currentStatus: json["currentStatus"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "currentStatus": currentStatus,
    };
}
