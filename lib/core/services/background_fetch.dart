import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/local_data/shared_preferences_services.dart';
import 'package:family_guard/core/services/background_dependency_injection.dart';
import 'package:family_guard/core/services/connectivity_services.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/home/data/datasource/tracking_data_source.dart';
import 'package:family_guard/features/home/data/models/tracking_model.dart';
import 'package:family_guard/features/home/data/repository/tracking_repository.dart';
import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:get/get.dart';

import '../../features/authentication/data/models/user_model.dart';

// [Android-only] This "Headless Task" is run when the Android app is terminated with `enableHeadless: true`
// Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch] Headless event received.');
  // Do your work here...
  // Only available for flutter 3.0.0 and later
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await BackgroundDependencyInjection().init();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  gl.Position? _curentPosition;
  bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
  await gl.Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true)
      .then((Position position) {
    _curentPosition = position;
    uploadPosition(position, serviceEnabled);
    print("bg location ${position.latitude}");
  }).catchError((e) {
    Fluttertoast.showToast(msg: e.toString());
  });

  flutterLocalNotificationsPlugin.show(
    888,
    'COOL SERVICE',
    'Awesome ${DateTime.now()}',
    const NotificationDetails(
      iOS: DarwinNotificationDetails(
          subtitle: 'Family Guard SERVICE',
          presentBadge: true,
          threadIdentifier: 'your.uturnsoftware.notification_identifier',
          categoryIdentifier: 'your.uturnsoftware.notification_identifier'),
      android: AndroidNotificationDetails(
        'my_foreground',
        'Family Guard SERVICE',
        icon: 'ic_bg_service_small',
        ongoing: true,
      ),
    ),
  );
  BackgroundFetch.finish(taskId);
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> initPlatformState() async {
  // Configure BackgroundFetch.
  int status = await BackgroundFetch.configure(
      BackgroundFetchConfig(
          minimumFetchInterval: 15,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE), (String taskId) async {
    // <-- Event handler

    // IMPORTANT:  You must signal completion of your task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }, (String taskId) async {
    // <-- Task timeout handler.
    // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
    BackgroundFetch.finish(taskId);
  });
  print('[BackgroundFetch] configure success: $status');
  BackgroundFetch.start();
}

Future<String> uploadPosition(Position position, bool serviceEnabled) async {
  // BackgroundIsolateBinaryMessenger.ensureInitialized(args[3]);

  ConnectivityResult connectivityResult =
      await ConnectivityService().isConnected();
  bool isConnected = (connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.mobile);

  gc.Placemark placemark =
      (await gc.placemarkFromCoordinates(position.latitude, position.longitude))
          .first;
  TrackingEntity trackingEntity = TrackingModel(
    id: 0,
    mobile: '',
    country: placemark.country == null || placemark.country!.isEmpty
        ? "No Country"
        : placemark.country!.tr,
    adminArea: placemark.administrativeArea == null ||
            placemark.administrativeArea!.isEmpty
        ? "No Admin Area"
        : placemark.administrativeArea!.tr,
    subAdminArea: placemark.subAdministrativeArea == null ||
            placemark.subAdministrativeArea!.isEmpty
        ? "No Sub Admin Area"
        : placemark.subAdministrativeArea!.tr,
    locality: placemark.locality == null || placemark.locality!.isEmpty
        ? "No Locality"
        : placemark.locality!.tr,
    subLocality: placemark.subLocality == null || placemark.subLocality!.isEmpty
        ? "No Sub Locality"
        : placemark.subLocality!.tr,
    street: placemark.street == null || placemark.street!.isEmpty
        ? "No Street Name"
        : placemark.street!.tr,
    postalCode: placemark.postalCode == null || placemark.postalCode!.isEmpty
        ? "No Postal Code"
        : placemark.postalCode!,
    lat: position.latitude,
    lon: position.longitude,
    speed: position.speed == 0.0 ? 0.0001 : position.speed,
  );
  /*  location.changeNotificationOptions(
            title: 'Family Guard',
            subtitle: 'Geolocation detection ${currentLocation.latitude}',
            iconName: 'ic_bg_service_small'); */
  String response = "";

  try {
    if (isConnected == true && serviceEnabled == true) {
      String cachedData = await sl<SharedPreferencesServices>().getData(
        key: AppConstants.authCredential,
        dataType: DataType.string,
      );
      Map<String, dynamic> data = json.decode(cachedData);
      UserEntity? userEntity = UserModel.fromJson(data);
      log('Serice locations error ${jsonEncode(userEntity)}');
      Either<Failure, String> results = await AddNewUserLocationUsecase(
          baseTrackingRepository: TrackingRepository(
              baseTrackingDataSource: TrackingDataSource()))(TrackingParams(
          accessToken: userEntity.apiToken!, trackingEntity: trackingEntity));
      results.fold((l) {
        log('Service locations error ${l.message}');
        response = l.message;
        print('location upload ${l.message}');
      }, (r) {
        log('Service locations $r');
        response = r;
        print('location upload $r');
      });
    }
  } catch (e) {
    log('Location Fetcher error ${e.toString()}');
    response = e.toString();
  }

  return response;
  //Isolate.exit(args[0], response);
}
