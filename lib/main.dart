import 'package:delivery_app/firebase_options.dart';
import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/logic/services/notification_service.dart';
import 'package:delivery_app/src/presentation/my_application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("💬 Background Message Received: ${message.notification?.title}");
  if (message.notification != null) {
    NotificationService.flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'Used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.init();
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
