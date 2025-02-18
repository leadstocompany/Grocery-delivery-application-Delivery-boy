import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/presentation/my_application.dart';
import 'package:flutter/material.dart';

void main() {
  ServiceLocator.setup();
  runApp(const MyApplication());
}
