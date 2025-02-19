import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/core/utiils_lib/custom_dio_exception.dart';
import 'package:delivery_app/src/core/utiils_lib/response_type_def.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/data/login_response.dart';
import 'package:delivery_app/src/data/upload_image.dart';
import 'package:delivery_app/src/data/vendor_otpModel.dart';
import 'package:delivery_app/src/logic/services/auth_service_locator.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepo {
  final AuthServices _authServices;

  AuthRepo(this._authServices);

  FutureResult<String> sendOtp(data) async {
    try {
      var response = await _authServices.sendOtp(data);
      final String model = response.toString();

      return right(model);
    } on DioException catch (e) {
      print("dhfgfdgjdhfgfgh  ${e}");
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<VendorOtpModel> verifyOtp(data) async {
    try {
      var response = await _authServices.verifyOtp(data);

      final VendorOtpModel vendorOtpModel =
          vendorOtpModelFromJson(response.toString());

      if (vendorOtpModel.data != null) {
        await SharedPrefUtils.setToken(
            authToken: vendorOtpModel.data!.accessToken ?? "");
        await SharedPrefUtils.setRefreshToken(
            refresh_token: vendorOtpModel.data!.refreshToken ?? "");
      }

      return right(vendorOtpModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<UploadImage> uploadImage(File imageFile) async {
    try {
      final response = await _authServices.uploadImage(imageFile);
      UploadImage upload = uploadImageFromJson(response.toString());
      return right(upload);
    } on DioException catch (e) {
      final error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<LoginResponse> loginOtp(data) async {
    try {
      var response = await _authServices.loginOtp(data);

      LoginResponse loginResponse = loginResponseFromJson(response.toString());

      if (loginResponse.accessToken != null) {
        await SharedPrefUtils.setToken(
            authToken: loginResponse.accessToken ?? "");
        await SharedPrefUtils.setRefreshToken(
            refresh_token: loginResponse.refreshToken ?? "");
      }

      //  final String model = response.toString();

      return right(loginResponse);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  // FutureResult<LoginResponse> login(data) async {
  //   try {
  //     var response = await _authServices.login(data);

  //     LoginResponse loginResponse = loginResponseFromJson(response.toString());
  //     if (loginResponse.accessToken != null) {
  //       await SharedPrefUtils.setToken(
  //           authToken: loginResponse.accessToken ?? "");
  //       await SharedPrefUtils.setRefreshToken(
  //           refresh_token: loginResponse.refreshToken ?? "");
  //     }

  //     print("Response status code: ${response.statusCode}");

  //     return right(loginResponse);
  //   } on DioException catch (e) {
  //     print("DioException occurred: $e");

  //     if (e.response != null) {
  //       int statusCode = e.response!.statusCode ?? 0;
  //       var errorData = e.response!.data; // Error body from the server

  //       String errorMessage =
  //           errorData['message']['message'] ?? 'Unknown error';

  //       print("Error: $errorMessage (Status Code: $statusCode)");

  //       // Custom error handling
  //       var error = CustomDioExceptions.handleError(e);
  //       return left(error);
  //     } else {
  //       // Handle other DioExceptions without a response (e.g., network issues)
  //       var error = CustomDioExceptions.handleError(e);
  //       return left(error);
  //     }
  //   }
  // }

  FutureResult<String> customerRegister(data) async {
    try {
      var response = await _authServices.userRegister(data);

      final String model = response.toString();
      return right(model);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<String> customerLogOut(data) async {
    try {
      var response = await _authServices.customerLogOut(data);

      final String model = response.toString();

      return right(model);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }

  
  
  
  }
}
