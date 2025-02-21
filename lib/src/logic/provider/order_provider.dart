import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/data/delivery_order_model.dart';
import 'package:delivery_app/src/logic/repo/order_repo.dart';
import 'package:flutter/material.dart';

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
}
