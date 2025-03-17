import 'dart:io';

import 'package:delivery_app/src/core/utiils_lib/custom_dio_exception.dart';
import 'package:delivery_app/src/core/utiils_lib/response_type_def.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/data/delivery_order_model.dart';
import 'package:delivery_app/src/data/driver_wallet.dart';
import 'package:delivery_app/src/data/order_OTP.dart';
import 'package:delivery_app/src/data/status_response.dart';
import 'package:delivery_app/src/data/upload_image.dart';
import 'package:delivery_app/src/data/user_response.dart';
import 'package:delivery_app/src/logic/services/orderSirvice.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class OrderRepo {
  final OrderService _orderService;

  OrderRepo(this._orderService);

  FutureResult<DeliveryOrderModel> getMyOrder(data) async {
    print("hdgsfhjdfj  ");
    try {
      var response = await _orderService.getOrder(data);

      print("objectdjsfngjkdfjjfjb  $response");

      DeliveryOrderModel storeModel =
          deliveryOrderModelFromJson(response.toString());

      //final String model = response.toString();
      return right(storeModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<DeliveryOtpmodel> getAssignedOtp(data) async {
    try {
      var response = await _orderService.getAssignedOtp(data);

      DeliveryOtpmodel storeModel =
          deliveryOtpmodelFromJson(response.toString());

      //final String model = response.toString();
      return right(storeModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);

      return left(error);
    }
  }

  FutureResult<String> updateOTP(data) async {
    try {
      var response = await _orderService.updateOTP(data);

      //  DeliveryOtpmodel storeModel = deliveryOtpmodelFromJson(response.toString());

      final String model = response.toString();
      return right(model);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<StatusResponse> updateStatus(data) async {
    try {
      var response = await _orderService.updateStatus(data);

      StatusResponse storeModel = statusResponseFromJson(response.toString());

      // final String storeModelmodel = response.toString();
      return right(storeModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<String> declineAssign(data) async {
    try {
      var response = await _orderService.declineAssign(data);

      // StatusResponse storeModel = statusResponseFromJson(response.toString());

      final String storeModelmodel = response.toString();
      return right(storeModelmodel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<String> acceptAssign(data) async {
    try {
      var response = await _orderService.acceptAssign(data);

      // StatusResponse storeModel = statusResponseFromJson(response.toString());

      final String storeModelmodel = response.toString();
      return right(storeModelmodel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<UserResponse> getMe(data) async {
    try {
      var response = await _orderService.getMe(data);

      final UserResponse vendorModel =
          userResponseFromJson(response.toString());

      if (vendorModel != null) {
        print("kjdhgjkfjkghkjfg    ${vendorModel.id}");

        //SharedPrefUtils.USER_NAME =
        //vendorModel.firstName + " " + vendorModel.lastName;
        //SharedPrefUtils.PHONE = vendorModel.phone;
        //print("dkfjhdkfhkfk  ${SharedPrefUtils.USER_NAME}");

        await SharedPrefUtils.setUserId(id: vendorModel.id);
      }

      // final String model = response.toString();

      return right(vendorModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<UploadImage> uploadImage(File imageFile) async {
    try {
      final response = await _orderService.uploadImage(imageFile);
      UploadImage upload = uploadImageFromJson(response.toString());
      return right(upload);
    } on DioException catch (e) {
      final error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<String> updateProfile(data) async {
    try {
      var response = await _orderService.updateProfile(data);

      final String model = response.toString();
      return right(model);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  FutureResult<DriverWallet> getWallet(data) async {
    try {
      var response = await _orderService.getWallet(data);

      final DriverWallet prdouctModel =
          driverWalletFromJson(response.toString());

      return right(prdouctModel);
    } on DioException catch (e) {
      print("djfkgjgfkj  $e");
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }
}
