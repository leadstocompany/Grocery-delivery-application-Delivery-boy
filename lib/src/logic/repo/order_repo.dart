import 'package:delivery_app/src/core/utiils_lib/custom_dio_exception.dart';
import 'package:delivery_app/src/core/utiils_lib/response_type_def.dart';
import 'package:delivery_app/src/data/delivery_order_model.dart';
import 'package:delivery_app/src/data/order_OTP.dart';
import 'package:delivery_app/src/logic/services/orderSirvice.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';


class OrderRepo {
  final OrderService _orderService;

  OrderRepo(this._orderService);


  

  FutureResult<DeliveryOrderModel> getMyOrder(data) async 
  {
    try {
      var response = await _orderService.getOrder(data);

      print("objectdjsfngjkdfjjfjb");
      DeliveryOrderModel storeModel = deliveryOrderModelFromJson(response.toString());
     

      //final String model = response.toString();
      return right(storeModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

 FutureResult<DeliveryOtpmodel> getAssignedOtp(data) async 
  {
    try {
      var response = await _orderService.getAssignedOtp(data);

    
      DeliveryOtpmodel storeModel = deliveryOtpmodelFromJson(response.toString());
     

      //final String model = response.toString();
      return right(storeModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }


 FutureResult<DeliveryOtpmodel> updateOTP(data) async 
  {
    try {
      var response = await _orderService.updateOTP(data);

    
      DeliveryOtpmodel storeModel = deliveryOtpmodelFromJson(response.toString());
     

      //final String model = response.toString();
      return right(storeModel);
    } on DioException catch (e) {
      var error = CustomDioExceptions.handleError(e);
      return left(error);
    }
  }

  
}
