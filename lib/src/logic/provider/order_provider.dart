import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  // Store the expanded state of each item
  List<bool> _expandedItems = [];

  // Initialize the expanded state list with default values
  OrderProvider(int itemCount) {
    _expandedItems = List.generate(itemCount, (_) => false);
  }

  // Get expanded state for a specific item
  bool isExpanded(int index) 
  {
    return _expandedItems[index];
  }

  // Toggle the expanded state for a specific item
  void toggleExpanded(int index) 
  {
    _expandedItems[index] = !_expandedItems[index];
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
