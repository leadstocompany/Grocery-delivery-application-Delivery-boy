import 'dart:convert';

import 'package:delivery_app/src/core/constant/api.dart';
import 'package:delivery_app/src/core/network_services/api_services.dart';


class OrderService extends ApiService
{


  Future myOrder(data) async {
    var response = await api.get(APIURL.myOrder, data: jsonEncode(data));

    return response;
  }

}