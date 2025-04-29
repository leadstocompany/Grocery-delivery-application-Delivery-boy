import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/logic/repo/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddressProvider extends ChangeNotifier {
  bool ischeckpin = false;
  final _homeRepo = getIt<OrderRepo>();

  Future<bool> checkPin(BuildContext context, pin) async {
    ischeckpin = true;
    notifyListeners();
    var data = {};
    try {
      var result = await _homeRepo.checkPin(data, pin);

      return result.fold(
        (error) {
          Fluttertoast.showToast(
            msg: error.message + ",Please change pin cod!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          ischeckpin = false;
          return false;
        },
        (response) {
          ischeckpin = false;
          notifyListeners();
          return true;
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Please change pin cod!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      ischeckpin = false;
      notifyListeners();
      return false;
    }
  }

  bool isAddressed = false;

  setLoader(bool status) {
    isAddressed = status;
    notifyListeners();
  }

  Future<bool> addAddress(BuildContext context, name, pincode, phone,
      alternatePhoneNumber, address, landmark, addresstype) async {
    isAddressed = true;
    notifyListeners();
    var data = {
      "name": name,
      "pincode": pincode,
      "phoneNumber": "+91$phone",
      "alternatePhoneNumber": "+91$alternatePhoneNumber",
      "addressLine": address,
      "landmark": landmark,
      "addressType": addresstype,
      "isDefault": true,
      "additionalInstructions": "Please ring doorbell twice"
    };

    try {
      var result = await _homeRepo.addAddress(data);
      return result.fold(
        (error) {
          isAddressed = false;

          return false;
        },
        (response) {
          Fluttertoast.showToast(
            msg: "Address Added!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          isAddressed = false;
          notifyListeners();
          return true;
        },
      );
    } catch (e) {
      isAddressed = false;
      notifyListeners();
      return false;
    }
  }
}
