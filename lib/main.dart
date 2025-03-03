import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/presentation/my_application.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("💬 Background Message Received: ${message.notification?.title}");
}

void main() {
  ServiceLocator.setup();
  requestNotificationPermission();
  runApp(const MyApplication());
}

// void requestNotificationPermission() async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final bool? granted = await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()!
//       .requestNotificationsPermission(); // ✅ Correct method

//   if (granted != null && granted) {
//     print("✅ Notification permission granted");
//   } else {
//     print("❌ Notification permission denied");
//   }
// }
void requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print("✅ Notification permission granted");
    } else {
      print("❌ Notification permission denied");
    }
  } else {
    print("🔔 Notification permission already granted");
  }
}

