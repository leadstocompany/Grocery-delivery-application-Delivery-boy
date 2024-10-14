import 'package:flutter/material.dart';

class LeaveProvider with ChangeNotifier {
  int selectedDays = 1; // Default selected days
  DateTime? fromDate; // Selected from date
  DateTime? toDate; // Selected to date
  String selectedReason = ''; // Selected reason

  void updateSelectedDays(int value) {
    selectedDays = value;
    notifyListeners();
  }

  void updateFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void updateToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  void updateSelectedReason(String reason) {
    selectedReason = reason;
    notifyListeners();
  }
}
