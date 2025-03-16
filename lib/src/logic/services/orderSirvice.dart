import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/core/constant/api.dart';
import 'package:delivery_app/src/core/network_services/api_services.dart';
import 'package:dio/dio.dart';

class OrderService extends ApiService {
  Future getOrder(data) async {
    print("  djkhfgjkh  ${data}");

    var response;
    if (data is Map && data.isEmpty) {
      print("kgjfnhkjfghfgfg  ${data}");
      response = await api.get(APIURL.myOrder, data: jsonEncode(data));
    } else {
      response = await api.get(APIURL.myOrder,
          data: jsonEncode(data), queryParameters: data);
    }

    print("ksjfhgdjkhjg  $response");
    return response;
  }

  Future getAssignedOtp(data) async {
    var response = await api.get(APIURL.getAssignedOtp,
        data: jsonEncode(data), queryParameters: data);

    return response;
  }

  Future updateOTP(data) async {
    var response = await api.post(APIURL.updateOTP, data: jsonEncode(data));

    return response;
  }

  Future getMe(data) async {
    var response = await api.get(APIURL.getMe, data: jsonEncode(data));
    //response.statusCode

    return response;
  }

  Future updateStatus(data) async {
    var response = await api.patch(APIURL.updateStatus, data: jsonEncode(data));
    //response.statusCode

    return response;
  }

  Future declineAssign(data) async {
    var response = await api.post(APIURL.declineAssign, data: jsonEncode(data));
    //response.statusCode

    return response;
  }

  Future acceptAssign(data) async {
    var response = await api.post(APIURL.acceptAssign, data: jsonEncode(data));
    //response.statusCode

    return response;
  }

  Future updateProfile(data) async {
    var response =
        await api.patch(APIURL.updateProfile, data: jsonEncode(data));
    return response;
  }

  Future<Response> uploadImage(File imageFile,
      {Map<String, dynamic>? additionalFields}) async {
    const String url = APIURL.uploadImage;
    return await api.uploadImage(
      url,
      imageFile,
      additionalFields: additionalFields,
    );
  }

  Future getWallet(data) async {
    var response = await api.get(APIURL.getWallet,
        data: jsonEncode(data), queryParameters: data);

    return response;
  }
}
