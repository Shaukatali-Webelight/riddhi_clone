// Dart imports:
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/services/notification/local_notification_service.dart';
// Project imports:

class FirebaseMessagingService {
  FirebaseMessagingService._();

  static FirebaseMessagingService instance = FirebaseMessagingService._();

  FirebaseMessaging? _messaging;

  String? environment;

  Future<void> init() async {
    try {
      // 1. Instantiate Firebase Messaging
      _messaging = FirebaseMessaging.instance;

      // 2. On iOS, this helps to take the user permissions
      final settings = await _messaging?.requestPermission();

      // 3. on Message Listen
      if (settings?.authorizationStatus == AuthorizationStatus.authorized) {
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          LogHelper.logInfo('**Notification Foreground** ${message.toMap()}');

          if (Platform.isAndroid) {
            await LocalNotificationService.instance.showNotification(
              title: message.notification?.title,
              body: message.notification?.body,
              payload: message.data['payload'] as String?,
            );
          }
        });

        //4. background message using backgroundHandler
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

        //5. On message open app
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
          handleMessage(message);
          LogHelper.logSuccess('**onMessageOpenedApp** Called');
        });
      } else {
        LogHelper.logSuccess(
          'Messaging Permission -> User declined or has not accepted permission',
        );
      }
    } catch (e) {
      LogHelper.logError('Error initializing Firebase: $e');
    }
  }

  void dispose() {
    FirebaseMessaging.onMessage.listen((_) {}).cancel();
    FirebaseMessaging.onMessageOpenedApp.listen((_) {}).cancel();
  }

  //6. get FCM Token
  Future<String?> getFcmToken() async {
    try {
      final fcmToken = await _messaging?.getToken() ?? '';
      LogHelper.logSuccess('FCMToken $fcmToken');
      return fcmToken;
    } catch (e) {
      LogHelper.logError('Failed to get FCM token $e');
      return null;
    }
  }

  //7. get initial message
  /// This method is called when the app is opened from a terminated state
  /// and a notification is tapped.
  Future<void> getInitialMessage() async {
    try {
      final message = await _messaging?.getInitialMessage();
      if (message != null) {
        LogHelper.logSuccess('Initial message: ${message.data}');
        handleMessage(message);
      } else {
        LogHelper.logSuccess('No initial message');
      }
    } catch (e) {
      LogHelper.logError('Failed to get initial message: $e');
    }
  }

  Future<void> deleteFCMToken() async {
    LogHelper.logSuccess('Delete FCM token deleted');
    await _messaging?.deleteToken();
  }

  void handleMessage(RemoteMessage message) {
    try {
      // Extract payload
      final payloadStr = message.data['payload'];
      if (payloadStr == null) {
        LogHelper.logError('Notification payload is null');
        return;
      }

      Map<String, dynamic> payload;
      // Check if it's already a Map or a JSON string
      if (payloadStr is Map<String, dynamic>) {
        payload = payloadStr;
      } else {
        try {
          // Cast the result of jsonDecode to Map<String, dynamic>
          final decodedPayload = jsonDecode(payloadStr as String? ?? '');
          if (decodedPayload is Map<String, dynamic>) {
            payload = decodedPayload;
          } else {
            LogHelper.logError('Payload is not a valid map: $decodedPayload');
            return;
          }
        } catch (e) {
          LogHelper.logError('Failed to parse notification payload: $e');
          return;
        }
      }

      // Extract notification data
      final metaData = payload['meta'];
      if (metaData == null) {
        LogHelper.logError('Notification Meta Data is null');
        return;
      }

      // Access data with proper type casting
      final notificationType = payload['notification_type'] as String?;
      final meta = metaData as Map<String, dynamic>?;

      if (notificationType == null) {
        LogHelper.logError('Notification type is null');
        return;
      }

      LogHelper.logSuccess('Handling notification: $notificationType');
      LogHelper.logSuccess('Notification meta: $meta');
      // _navigateBasedOnNotificationType(notificationType: notificationType, meta: Meta.fromJson(meta ?? {}));
    } catch (e) {
      LogHelper.logError('Error handling notification: $e');
    }
  }
}

// void _navigateBasedOnNotificationType({
//   required String notificationType,
//   required Meta meta,
// }) {
//   if (notificationType == NotificationType.newMaterialAllocation.value) {
//     AppNavigation.push(
//       page: const DemoMaterialScreen(),
//     );
//   } else if (notificationType == NotificationType.demoMeetingScheduled.value) {
//     AppNavigation.push(
//       page: DemoMeetingDetailScreen(
//         meetingId: meta.meetingID ?? 0,
//         isCheckInCheckOutVisible: true,
//       ),
//     );
//   } else if (notificationType == NotificationType.materialTransfer.value) {
//     AppNavigation.push(
//       page: const DemoMaterialStockScreen(),
//     );
//   } else if (notificationType == NotificationType.sdoAppointmentRequestApproved.value) {
//     AppNavigation.push(
//       page: SDOViewDetailsScreen(
//         isFromSdoApproval: true,
//         appointmentId: meta.sdoAppointmentId ?? 0,
//       ),
//     );
//   } else if (notificationType == NotificationType.sdoAppointmentRequestRejected.value) {
//     AppNavigation.push(
//       page: SDOViewDetailsScreen(
//         isFromSdoApproval: false,
//         appointmentId: meta.sdoAppointmentId ?? 0,
//       ),
//     );
//   } else if (notificationType == NotificationType.sdoTerminationRequestApproved.value) {
//     AppNavigation.push(
//       page: SDOTerminationViewDetailsScreen(
//         isFromSdoApproval: true,
//         terminationId: meta.sdoTerminationId ?? 0,
//         showActionButton: true,
//       ),
//     );
//   } else if (notificationType == NotificationType.sdoTerminationRequestRejected.value) {
//     AppNavigation.push(
//       page: SDOTerminationViewDetailsScreen(
//         isFromSdoApproval: false,
//         terminationId: meta.sdoTerminationId ?? 0,
//       ),
//     );
//   }
// }

//8. backgroundHandle
@pragma('vm:entry-point')
//ignore:avoid-unused-parameters, //* onBackgroundMessage take function with param so it is required to add ignore here.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await LocalNotificationService.instance.init();
}
