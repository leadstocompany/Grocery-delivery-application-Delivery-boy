import 'dart:convert';

import 'package:delivery_app/src/core/constant/api.dart';
import 'package:delivery_app/src/core/network_services/api_services.dart';

class OrderService extends ApiService {
  Future getOrder(data) async {
    var response = await api.get(APIURL.myOrder, data: jsonEncode(data));

    return response;
  }

  Future getAssignedOtp(data) async {
    var response = await api.get(APIURL.getAssignedOtp,
        data: jsonEncode(data), queryParameters: data);

    return response;
  }


    Future updateOTP(data) async {
    var response = await api.post(APIURL.updateOTP,
        data: jsonEncode(data));

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






  
}
