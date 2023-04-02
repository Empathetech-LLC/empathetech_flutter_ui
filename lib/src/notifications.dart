library empathetech_flutter_ui;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notifsPlugin = FlutterLocalNotificationsPlugin();

/// Foreground [NotificationResponse]/action
void notifAction(NotificationResponse notificationResponse) {}

/// Background [NotificationResponse]/action
/// Must be a top-level function
@pragma('vm:entry-point')
void backgroundNotifAction(NotificationResponse notificationResponse) {}

// Android setup

const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

const androidNotifDetails = AndroidNotificationDetails(
  'local',
  'local',
  importance: Importance.high,
  priority: Priority.high,
  playSound: true,
);

// iOS setup

final DarwinInitializationSettings iosInitSettings = DarwinInitializationSettings();

const iosNotifDetails = DarwinNotificationDetails(
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
);

/// Setup a simple push notification manager/service
/// Built from [flutter_local_notifications]
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

  /// Initialize the [NotificationService]
  /// Load platform specific settings
  /// Define [NotificationResponse] actions
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

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await notifsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp == true &&
        notificationAppLaunchDetails?.notificationResponse != null) {
      backgroundNotifAction(
          notificationAppLaunchDetails!.notificationResponse!); // handle / navigate
    }
  }

  /// Display notification
  Future<void> show(int id, String? title, String? body, String? payload) async {
    await notifsPlugin.show(
      id,
      title,
      body,
      appNotifDetails,
    );
  }
}
