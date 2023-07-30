import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:family_guard/core/models/notification_model.dart';
import 'package:family_guard/core/widget/custom_snackbar.dart';

class FirebaseMessagingServices {
  Future<String?> deviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static bool isInitialized = false;

  initializeNotifications() async {
    if (isInitialized) return;

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      NotificationModel notificationModel = getEventMessage(message);
      log('Message data: ${notificationModel.toMap()}');
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification!.toMap()}');
        CustomSnackBar.showSnackBarSingleLine(
            description: message.notification!.body ?? ' ',
            title: message.notification!.title ?? ' ',
            mainButton: SnackBarCloseButton(
              onTap: () => Get.closeAllSnackbars(),
            ));
      }
    });

    FirebaseMessaging.instance.onTokenRefresh
        .listen((event)async {
          
        })
        .onError((error) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      NotificationModel notificationModel = getEventMessage(message);
      log('Message data: ${notificationModel.toMap()}');
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification!.toMap()}');
        CustomSnackBar.showSnackBarSingleLine(
            description: message.notification!.body ?? ' ',
            title: message.notification!.title ?? ' ',
            mainButton: SnackBarCloseButton(
              onTap: () => Get.closeAllSnackbars(),
            ));
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    isInitialized = true;
  }
}

NotificationModel getEventMessage(RemoteMessage event) {
  log('Message data: ${NotificationModel.fromMap(event).toMap()}');
  return NotificationModel.fromMap(event);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
  getEventMessage(message);
}
