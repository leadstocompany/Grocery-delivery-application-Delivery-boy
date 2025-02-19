import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/core/constant/api.dart';
import 'package:delivery_app/src/core/network_services/api_services.dart';
import 'package:dio/dio.dart';


class ProductService extends ApiService {
  Future getMe(data) async {
    var response = await api.get(APIURL.getMe, data: jsonEncode(data));
    //response.statusCode

    return response;
  }

  Future refresh_token(data) async {
    var response = await api.post(APIURL.refresh_token, data: jsonEncode(data));

    return response;
  }

  Future getAllProduct(data, id) async {
    var response;

    if (id.isEmpty) {
      response = await api.get(APIURL.getAllProduct,
          queryParameters: data, data: data);
    } else {
      response =
          await api.get(APIURL.getAllProduct + id, data: jsonEncode(data));
    }

    return response;
  }

  Future getProductDetails(data, id) async {
    var response =
        await api.get(APIURL.getProductDetails + id, data: jsonEncode(data));

    return response;
  }

  //

  Future getBestDealProduct(data) async {
    var response = await api.get(APIURL.getBestDealProduct,
        queryParameters: data, data: jsonEncode(data));

    return response;
  }

  Future getAllcategory(data) async {
    var response = await api.get(APIURL.getAllcategory, data: jsonEncode(data));

    return response;
  }

  Future paymentOrder(data) async {
    var response = await api.post(APIURL.paymentOrder, data: jsonEncode(data));

    return response;
  }

  Future paymentCODOrder(data) async {
    print("kdjfgkjjkdfgkjdkfgjkdfgj  ${data}");
    var response =
        await api.post(APIURL.paymentCODOrder, data: jsonEncode(data));

    return response;
  }

  Future similarProduct(data, id) async {
    var response = await api.get(APIURL.similarProduct + id + "/similar",
        data: jsonEncode(data));

    return response;
  }

  Future getItemCards(data) async {
    var response = await api.get(APIURL.getItemCards, data: jsonEncode(data));

    return response;
  }

  Future offerCoupon(data) async {
    var response = await api.get(APIURL.offerCoupon, data: jsonEncode(data));

    return response;
  }

  Future applyCoupon(data) async {
    var response = await api.post(APIURL.applyCoupon, data: jsonEncode(data));

    return response;
  }

  Future checkPin(data, pin) async {
    var response = await api.get(APIURL.checkPin + pin, data: jsonEncode(data));

    return response;
  }

  Future deleteItem(data, id) async {
    var response =
        await api.delete(APIURL.deleteItem + id, data: jsonEncode(data));
    return response;
  }

  Future addAddress(data) async {
    var response = await api.post(APIURL.addAddress, data: jsonEncode(data));

    return response;
  }

  Future getProfile(data) async {
    var response = await api.get(APIURL.getprofile, data: jsonEncode(data));
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

  Future getAddress(data) async {
    var response = await api.get(APIURL.userAddress, data: jsonEncode(data));
    return response;
  }

  Future addToWish(data) async {
    var response = await api.post(APIURL.addToWish, data: jsonEncode(data));

    return response;
  }

  Future addToCart(data) async {
    var response = await api.post(APIURL.addToCart, data: jsonEncode(data));

    return response;
  }

  Future decreaseQuantity(data) async {
    var response = await api.patch(APIURL.addToCart, data: jsonEncode(data));

    return response;
  }

  Future gettAllWishList(data) async {
    var response =
        await api.get(APIURL.gettAllWishList, data: jsonEncode(data));

    return response;
  }

  Future getBanners(data) async {
    var response = await api.get(APIURL.getBanners, data: jsonEncode(data));

    return response;
  }

 
}
