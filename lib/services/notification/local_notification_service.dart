import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riddhi_clone/services/notification/firebase_notification_service.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService instance = LocalNotificationService._();

  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  //1. local notification Initialization for Android and IOS
  Future<void> init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        FirebaseMessagingService.instance.handleMessage(RemoteMessage(data: {'payload': notificationResponse.payload}));
      },
    );
  }

  //3. show notification
  Future<void> showNotification({String? title, String? body, String? payload}) async {
    const android = AndroidNotificationDetails(
      '1',
      'APP',
      channelDescription: 'CHANNEL DESCRIPTION',
      priority: Priority.high,
      importance: Importance.max,
    );

    const iOS = DarwinNotificationDetails();
    const platform = NotificationDetails(iOS: iOS, android: android);
    await _flutterLocalNotificationsPlugin?.show(
      0,
      title,
      body,
      platform,
      payload: payload,
    );
  }

  void clearNotifications() {
    _flutterLocalNotificationsPlugin?.cancelAll();
  }
}
