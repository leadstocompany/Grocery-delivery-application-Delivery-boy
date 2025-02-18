// import 'dart:convert';

// import 'package:vendor_app/src/core/constant/api.dart';
// import 'package:vendor_app/src/core/network_services/api_services.dart';
// import 'package:vendor_app/src/core/utiils_lib/shared_pref_utils.dart';

// class StoreService extends ApiService {
//   Future createStore(data) async {
//     var response = await api.post(APIURL.createStore, data: jsonEncode(data));
//     return response;
//   }

//   Future getStore(data) async {
//     String storeId = "${await SharedPrefUtils.getStoreId()}";
//     print("lkdsjhgjhdfgh  ${APIURL.getStore + storeId}");

//     var response =
//         await api.get(APIURL.getStore + storeId, data: jsonEncode(data));
//     return response;
//   }

//   Future logoutVendor(data) async {
//     var response = await api.post(APIURL.vendorLogOut, data: jsonEncode(data));
//     return response;
//   }

//   Future updateStore(data) async {
//     var response = await api.patch(APIURL.updateStore, data: jsonEncode(data));
//     return response;
//   }

  
// }
