// To parse this JSON data, do
//
//     final uploadImage = uploadImageFromJson(jsonString);

import 'dart:convert';

UploadImage uploadImageFromJson(String str) =>
    UploadImage.fromJson(json.decode(str));

String uploadImageToJson(UploadImage data) => json.encode(data.toJson());

class UploadImage {
  int? status;
  String? message;
  Image? data;

  UploadImage({
    this.status,
    this.message,
    this.data,
  });

  factory UploadImage.fromJson(Map<String, dynamic> json) => UploadImage(
        status: json["status"],
        message: json["message"],
        data: Image.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Image {
  String? url;
  String? publicId;

  Image({
    this.url,
    this.publicId,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        publicId: json["publicId"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "publicId": publicId,
      };
}
