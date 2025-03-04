// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   late IO.Socket socket;
//   final String driverId;

//   SocketService(this.driverId);

//   void connect() {
//     socket = IO.io(
//       'http://210.89.44.183:3333',
//       IO.OptionBuilder()
//           .setTransports(['websocket']) // Use WebSocket transport
//           .setQuery({'driverId': driverId}) // Send driverId as a query param
//           .setReconnectionAttempts(5) // Auto-reconnect attempts
//           .build(),
//     );

//     socket.onConnect((_) {
//       print('✅ Connected to WebSocket');
//     });

//     socket.onDisconnect((_) {
//       print('❌ Disconnected from WebSocket');
//     });

//     // Listen for 'timerUpdate' event
//     socket.on('timerUpdate', (data) {
//       print('🕒 Timer Update: $data');
//     });

//     // Listen for 'assignmentAccepted' event
//     socket.on('assignmentAccepted', (data) {
//       print('✅ Assignment Accepted: $data');
//     });

//     socket.connect();
//   }

//   void disconnect() {
//     socket.disconnect();
//   }
// }
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

// class SocketService
// {
//   late IO.Socket socket;
//   final String driverId;
//   final Function(Map<String, dynamic>) onTimerUpdate; // Callback to show popup

//   SocketService(this.driverId, this.onTimerUpdate);

//   void connect()
//    {
//     socket = IO.io(
//       'http://210.89.44.183:3333',
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .setQuery({'driverId': driverId})
//           .setReconnectionAttempts(5)
//           .build(),
//     );

//     socket.onConnect((_) {
//       print('✅ Connected to WebSocket');
//     });

//     socket.onDisconnect((_) {
//       print('❌ Disconnected from WebSocket');
//     });

//     socket.on('timerUpdate', (data) {
//       print('🕒 Timer Update: $data');
//       if (data != null) {
//         onTimerUpdate(data);
//         showNotification(data);
//       }
//     });

//     socket.connect();
//   }

//   void disconnect() {
//     socket.disconnect();
//   }

//   // Show notification
//   void showNotification(Map<String, dynamic> data) async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         print('🔔 Notification Clicked: ${response.payload}');
//         // Handle notification click, show popup
//         onTimerUpdate(jsonDecode(response.payload!));
//       },
//     );

//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'timer_update_channel',
//       'Timer Updates',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const NotificationDetails details = NotificationDetails(android: androidDetails);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       "New Order Assigned",
//       "Tap to view the timer",
//       details,
//       payload: jsonEncode(data),
//     );

//     // Play alert sound
//     FlutterRingtonePlayer.playNotification();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with WidgetsBindingObserver {
  late IO.Socket socket;
  final String driverId;
  final Function(Map<String, dynamic>) onTimerUpdate;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  SocketService(this.driverId, this.onTimerUpdate) {
    WidgetsBinding.instance.addObserver(this);
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('🔔 Notification Clicked: ${response.payload}');
        if (response.payload != null) {
          onTimerUpdate(jsonDecode(response.payload!));
        }
      },
    );
  }

  void connect() {
    socket = IO.io(
      'https://grocery.frontshopemporium.com',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'driverId': driverId})
          .setReconnectionAttempts(5)
          .build(),
    );

    socket.onConnect((_) {
      print('✅ Connected to WebSocket');
    });

    // socket.onDisconnect((_) {
    //   print('❌ Disconnected from WebSocket');
    // });

    socket.on('timerUpdate', (data) {
      print('🕒 Timer Update: $data');
      if (data != null) {
        if (_isAppInBackground()) {
          showNotification(data);
        } else {
          onTimerUpdate(data);
        }
      }
    });

    // Listen for 'assignmentAccepted' event
    socket.on('assignmentAccepted', (data) {
      print('✅ Assignment Accepted: $data');
    });

    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  bool _isAppInBackground() {
    return WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed;
  }

  void showNotification(Map<String, dynamic> data) async {
    if (!_isAppInBackground()) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'timer_update_channel',
      'Timer Updates',
      importance: Importance.high,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound(
      //'notification_sound'),
      playSound: true,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      "New Order Assigned",
      "You have a new order request. Tap to view details and take action.",
      details,
      payload: jsonEncode(data),
    );

    FlutterRingtonePlayer.playNotification();

    // FlutterRingtonePlayer.play(
    //   android: AndroidSounds.notification, // Default notification sound
    //   ios: IosSounds.glass,
    //   looping: false,
    //   volume: 1.0,
    //   asAlarm: false,
    // );
  }
}
