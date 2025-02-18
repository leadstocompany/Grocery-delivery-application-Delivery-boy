// import 'package:dio/dio.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:vendor_app/src/core/utiils_lib/custom_dio_exception.dart';
// import 'package:vendor_app/src/core/utiils_lib/response_type_def.dart';
// import 'package:vendor_app/src/data/store_model.dart';
// import 'package:vendor_app/src/logic/services/store_locator.dart';

// class StoreRepo {
//   final StoreService _storeService;

//   StoreRepo(this._storeService);

//   FutureResult<String> createStore(data) async {
//     try {
//       var response = await _storeService.createStore(data);

//       final String model = response.toString();
//       return right(model);
//     } on DioException catch (e) {
//       var error = CustomDioExceptions.handleError(e);
//       return left(error);
//     }
//   }

//     FutureResult<String> updateStore(data) async {
//     try {
//       var response = await _storeService.updateStore(data);

//       final String model = response.toString();
//       return right(model);
//     } on DioException catch (e) {
//       var error = CustomDioExceptions.handleError(e);
//       return left(error);
//     }
//   }


  

//   FutureResult<StoreModel> getStore(data) async 
//   {
//     try {
//       var response = await _storeService.getStore(data);

//       print("objectdjsfngjkdfjjfjb");
//       StoreModel storeModel = storeModelFromJson(response.toString());
//       if (storeModel != null)
//        {
//         print("objectdjsfngjkdfjjfjbetyrtytryut");
//       }

//       final String model = response.toString();
//       return right(storeModel);
//     } on DioException catch (e) {
//       var error = CustomDioExceptions.handleError(e);
//       return left(error);
//     }
//   }
//   FutureResult<String> vendorLogOut(data) async {
//     try {
//       var response = await _storeService.logoutVendor(data);

//       final String model = response.toString();
//       return right(model);
//     } on DioException catch (e) {
//       var error = CustomDioExceptions.handleError(e);
//       return left(error);
//     }
//   }

  
// }
