import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/services/connectivity_services.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/location_fetcher.dart';
import 'package:family_guard/features/home/data/datasource/tracking_data_source.dart';
import 'package:family_guard/features/home/data/models/tracking_model.dart';
import 'package:family_guard/features/home/data/repository/tracking_repository.dart';
import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as gc;

Future<void> initializeBackroundService() async {
  final service = FlutterBackgroundService();
  DisableBatteryOptimization.showDisableAllOptimizationsSettings('App Process',
      'Enable App Battery Usage', 'Battery Optimization', 'Enable process');

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'Family Guard Location Update', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'Family Guard Service',
      initialNotificationContent: 'Updating your location',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer.periodic(Duration(minutes: 1), (timer) async {
    LocationData locationData = await LocationFetcher.instance.getLocation();
    flutterLocalNotificationsPlugin.show(
      888,
      'Family Guard',
      "Family Guard is updating your location  lat: ${locationData.latitude} lon: ${locationData.longitude}",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'my_foreground',
          'Family Guard SERVICE',
          icon: 'ic_bg_service_small',
          ongoing: true,
        ),
      ),
    );
  });

  return true;
}

@pragma('vm-entry-point')
Future<void> onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 3), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'Family Guard SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        service.setForegroundNotificationInfo(
          title: "Family Guard",
          content:
              "Family Guard is updating your location  lat: ${locationData.latitude} lon: ${locationData.longitude}",
        );
      }
    }
  });
}


