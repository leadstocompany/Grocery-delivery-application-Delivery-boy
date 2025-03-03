import 'dart:io';

import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/core/utiils_lib/snack_bar.dart';
import 'package:delivery_app/src/core/utiils_lib/string/app_string.dart';
import 'package:delivery_app/src/data/delivery_order_model.dart';
import 'package:delivery_app/src/logic/repo/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderProvider with ChangeNotifier {
  // Store the expanded state of each item
  List<bool> _expandedItems = [];

  // Initialize the expanded state list with default values
  setItem(int itemCount) {
    _expandedItems = List.generate(itemCount, (_) => false);
  }

  // Get expanded state for a specific item
  bool isExpanded(int index) {
    return _expandedItems[index];
  }

  // Toggle the expanded state for a specific item
  void toggleExpanded(int index) {
    _expandedItems[index] = !_expandedItems[index];
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  DateTime? fromDate;

  void updateFromDate(DateTime date) {
    fromDate = date;
    notifyListeners(); // Notify listeners to rebuild widgets
  }

  final _orderRepo = getIt<OrderRepo>();

  List<Datum> orderList = [];
  bool isloading = true;

  Future<void> getMyOrder(BuildContext context) async {
    var data = {};
    try {
      var result = await _orderRepo.getMyOrder(data);

      return result.fold(
        (error) {
          isloading = false;

          notifyListeners();
        },
        (response) {
          print("dfjgkgjhfgkhjfgh  ${response.data}");
          orderList = response.data!;
          setItem(orderList.length);

          isloading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      print("sfddsfdfff  $e");

      isloading = false;
      notifyListeners();
    }
  }

  bool isSendOtp = false;

  Future<void> getAssignedOtp(BuildContext context, String assignmentId) async {
    isSendOtp = true;

    notifyListeners();
    var data = {"assignmentId": assignmentId};

    print("ldflkgfkgjdh   ${data}");

    try {
      var result = await _orderRepo.getAssignedOtp(data);

      return result.fold(
        (error) {
          isSendOtp = false;

          notifyListeners();
        },
        (response) {
          _showOtpPopup(context, response.code!); //

          isSendOtp = false;
          notifyListeners();
        },
      );
    } catch (e) {
      isSendOtp = false;
      notifyListeners();
    }
  }

  void _showOtpPopup(BuildContext context, String otp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text("Your OTP")), // Center the title
        content: Column(
          mainAxisSize: MainAxisSize.min, // Prevent excessive height
          children: [
            Center(
              child: Text(
                otp,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> updateOTP(
      BuildContext context, String deliveryAssignmentId, String otpCode) async
       {
    context.showLoader(show: true);

    var data = {
      "deliveryAssignmentId": deliveryAssignmentId,
      "otpCode": otpCode
    };
    try {
      var result = await _orderRepo.updateOTP(data);

      return result.fold(
        (error) {
          context.showLoader(show: false);
          Fluttertoast.showToast(
            msg: " Invalid, used, or expired OTP",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          return false;
        },
        (response) {
          context.showLoader(show: false);
          getMyOrder(context);
          Fluttertoast.showToast(
            msg: "Product delivered successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );

          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return false;
    }
  }

  bool _isOnline = false;

  bool get isOnline => _isOnline;

  Future<void> loadOnlineStatus() async {
    _isOnline = await SharedPrefUtils.getOnDuty() ?? false;
    notifyListeners();
  }

  Future<void> toggleOnlineStatus(BuildContext context, bool isOnline) async {
    if (!isOnline) {
      _isOnline = true;
      notifyListeners();

      updateStatus(context, "ONLINE");
      await SharedPrefUtils.setOnDuty(status: true);
    } else {
      _isOnline = false;
      notifyListeners();
      updateStatus(context, "OFFLINE");
      await SharedPrefUtils.setOnDuty(status: false);
    }
    // _isOnline = !_isOnline;
  }

  Future<bool> updateStatus(BuildContext context, String orderStatus) async {
    context.showLoader(show: true);

    var data = {
      "status": orderStatus,
    };
    try {
      var result = await _orderRepo.updateStatus(data);

      return result.fold(
        (error) {
          context.showLoader(show: false);
          Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          return false;
        },
        (response) {
          context.showLoader(show: false);

          Fluttertoast.showToast(
            msg: "${response.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 14.0,
          );

          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);
      Fluttertoast.showToast(
        msg: " $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return false;
    }
  }

  Future<bool> acceptAssign(BuildContext context, String assignmentId) async {
    context.showLoader(show: true);

    var data = {"assignmentId": assignmentId};
    try {
      var result = await _orderRepo.acceptAssign(data);

      return result.fold(
        (error) {
          context.showLoader(show: false);
          Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          return false;
        },
        (response) {
          context.showLoader(show: false);
          getMyOrder(context);

          Fluttertoast.showToast(
            msg: "Order accepted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 14.0,
          );

          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);
      Fluttertoast.showToast(
        msg: " Invalid, used, or expired OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return false;
    }
  }

  Future<bool> declineAssign(BuildContext context, String assignmentId) async {
    context.showLoader(show: true);

    var data = {
      "assignmentId": assignmentId,
      "reason": "Driver is unavailable"
    };
    try {
      var result = await _orderRepo.declineAssign(data);

      return result.fold(
        (error) {
          context.showLoader(show: false);
          Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          return false;
        },
        (response) {
          context.showLoader(show: false);
          Fluttertoast.showToast(
            msg: "Order declined successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 14.0,
          );

          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);
      Fluttertoast.showToast(
        msg: " Invalid, used, or expired OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return false;
    }
  }



  String _profile = '';
  String get profile => _profile;
  String _name = '';
  String get name => _name;
  String _email = '';
  String get email => _email;

  setValue() async 
  {
    _name = (await SharedPrefUtils.getFirstName())! +
        " " +
        (await SharedPrefUtils.getLastName())!;
    _email = (await SharedPrefUtils.getUserEmail())!;
    _profile = (await SharedPrefUtils.getUserProfile())!;
    notifyListeners();
  }

  Future<void> getMe() async {
    var data = {};

    try {
      var result = await _orderRepo.getMe(data);

      return result.fold(
        (error) {},
        (response) async {
          // setUserName(response.firstName + " " + response.lastName);
          // setPhone(response.phone);

          if (response.currentStatus != null) {
            if (response.currentStatus == "ONLINE") {
              print("lkjdhfgfjkgfgkjk  ${response.currentStatus}");
              await SharedPrefUtils.setOnDuty(status: true);
            } else {
              await SharedPrefUtils.setOnDuty(status: false);
            }
          }

          if (response.firstName != null && response.lastName != null) {
            SharedPrefUtils.saveUser(user: response);

            _profile = response.img ?? '';
            _name = response.firstName + " " + response.lastName;
            _email = response.email ?? "";

            AppString.userName = response.firstName ?? "";
            AppString.userLastName = response.lastName ?? "";
            AppString.userProfile = response.img ?? "";
          }

          SharedPrefUtils.USER_NAME =
              response.firstName + " " + response.lastName;
          SharedPrefUtils.PHONE = response.phone;
          notifyListeners();
        },
      );
    } catch (e) {}
  }

  bool _isImageLoading = false;
  bool get isImageLoading => _isImageLoading;
  String _uploadedUrl = '';
  Future<bool> uploadImage(BuildContext context, File? _selectedImage) async {
    context.showLoader(show: true);
    _isImageLoading = false;
    final result = await _orderRepo.uploadImage(_selectedImage!);
    context.showLoader(show: false);

    return result.fold(
      (error) {
        _showSnackBar(context, error.message, Colors.red);
        return false;
      },
      (uploadImage) {
        _isImageLoading = true;
        _uploadedUrl = uploadImage.data!.url.toString();
        notifyListeners();

        _showSnackBar(context, "Image uploaded successfully !", Colors.green);
        return true;
      },
    );
  }

  Future<bool> updateProfile(
      BuildContext context, String firstName, String lastName) async {
    context.showLoader(show: true);

    var data = {
      "firstName": firstName,
      "lastName": lastName,
      "img": _uploadedUrl
    };

    try {
      var result = await _orderRepo.updateProfile(data);

      context.showLoader(show: false);

      return result.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        },
        (response) {
          getMe();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Profile updated"),
              backgroundColor: Colors.green,
            ),
          );
          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    showTopSnackBar(context, message, color);
  }
}
