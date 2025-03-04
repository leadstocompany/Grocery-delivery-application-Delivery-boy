import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/presentation/my_application.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("💬 Background Message Received: ${message.notification?.title}");
}

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized(); 
  ServiceLocator.setup();
await requestNotificationPermission();
  runApp(const MyApplication());
}




Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.status;

  if (status.isDenied || status.isPermanentlyDenied) {
    status = await Permission.notification.request();
  }

  if (status.isGranted) {
    print("✅ Notification permission granted");
  } else if (status.isPermanentlyDenied) {
    print("⚠️ Notification permission permanently denied. Open settings.");
    openAppSettings();
  } else {
    print("❌ Notification permission denied.");
  }
}



