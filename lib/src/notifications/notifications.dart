import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//// Shared

final FlutterLocalNotificationsPlugin notifsPlugin = FlutterLocalNotificationsPlugin();

// Foreground action
void notifAction(NotificationResponse notificationResponse) {}

// Background action
@pragma('vm:entry-point') // == top-level function
void backgroundNotifAction(NotificationResponse notificationResponse) {}

//// Android

// Initialization settings
const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

// Notification details
const androidNotifDetails = AndroidNotificationDetails(
  'local',
  'local',
  importance: Importance.high,
  priority: Priority.high,
  playSound: true,
);

//// iOS

// Initialization settings
final DarwinInitializationSettings iosInitSettings = DarwinInitializationSettings();

// Notification details
const iosNotifDetails = DarwinNotificationDetails(
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
);

class NotificationService {
  // Build app settings
  final appInitSettings = InitializationSettings(
    android: androidInitSettings,
    iOS: iosInitSettings,
  );

  final appNotifDetails = NotificationDetails(
    android: androidNotifDetails,
    iOS: iosNotifDetails,
  );

  // Initialize plugin
  Future<void> init() async {
    await notifsPlugin.initialize(
      appInitSettings,
      onDidReceiveNotificationResponse: notifAction,
      onDidReceiveBackgroundNotificationResponse: backgroundNotifAction,
    );

    // Request permissions
    await notifsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    await notifsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: false,
        );
  }

  // Display notification
  Future<void> show(int id, String? title, String? body, String? payload) async {
    await notifsPlugin.show(
      id,
      title,
      body,
      appNotifDetails,
    );
  }
}
