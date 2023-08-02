import 'dart:developer';

import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/features/notifications/domain/usecases/refresh_token_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:family_guard/core/models/notification_model.dart';
import 'package:family_guard/core/widget/custom_snackbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingServices {
  Future<String?> deviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static bool isInitialized = false;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  initializeNotifications() async {
    if (isInitialized) return;

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

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
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground! ${message.data.toString()}');
      NotificationModel notificationModel = getEventMessage(message);
      log('Message data: ${message.toMap()}');

      flutterLocalNotificationsPlugin.show(
        notificationModel.hashCode,
        notificationModel.title,
        notificationModel.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    });

   

    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      log('refresh token started');
      await sl<RefreshTokenUsecase>()(event);
    }).onError((error) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      NotificationModel notificationModel = getEventMessage(message);
      log('Message data: ${notificationModel.toMap()}');
      log('Message also contained a notification: ${message.notification!.toMap()}');
      log('Message also contained a notification: ${message.notification!.toMap()}');
      CustomSnackBar.showSnackBarSingleLine(
          description: message.notification!.body ?? ' ',
          title: message.notification!.title ?? ' ',
          mainButton: SnackBarCloseButton(
            onTap: () => Get.closeAllSnackbars(),
          ));
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
