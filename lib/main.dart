import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/presentation/my_application.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("💬 Background Message Received: ${message.notification?.title}");
}

void main() {
  ServiceLocator.setup();
  runApp(const MyApplication());
}
