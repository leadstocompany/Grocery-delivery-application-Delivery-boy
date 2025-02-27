import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
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
      BuildContext context, String deliveryAssignmentId, String otpCode) async {
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
}
