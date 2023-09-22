import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/local_data/shared_preferences_services.dart';
import 'package:family_guard/core/services/background_dependency_injection.dart';
import 'package:family_guard/core/services/connectivity_services.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/features/authentication/data/models/user_model.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

import 'package:family_guard/features/home/data/datasource/tracking_data_source.dart';
import 'package:family_guard/features/home/data/models/tracking_model.dart';
import 'package:family_guard/features/home/data/repository/tracking_repository.dart';
import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:get/get.dart';

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
FutureOr<bool> onIosBackground(ServiceInstance service) async {
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
  await BackgroundDependencyInjection().init();

  Timer.periodic(const Duration(seconds: 20), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        gl.Position? curentPosition;
        bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
        await gl.Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                forceAndroidLocationManager: true)
            .then((Position position) {
          curentPosition = position;
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
                categoryIdentifier:
                    'your.uturnsoftware.notification_identifier'),
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
              "Family Guard is updating your location",
        );
      }
    }
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
  await BackgroundDependencyInjection().init();

  Timer.periodic(const Duration(seconds: 20), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        gl.Position? curentPosition;
        bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
        await gl.Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                forceAndroidLocationManager: true)
            .then((Position position) {
          curentPosition = position;
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
                categoryIdentifier:
                    'your.uturnsoftware.notification_identifier'),
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
              "Family Guard is updating your location",
        );
      }
    }
  });
}

/* isolateUploadLocation(Position position, bool serviceEnabled) async {
   WidgetsFlutterBinding.ensureInitialized();
  final ReceivePort receivePort = ReceivePort();
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  try {
    await Isolate.spawn(uploadPosition,
        [receivePort.sendPort, position, serviceEnabled, rootIsolateToken]);
  } catch (e) {
    log(e.toString());
    receivePort.close();
  }
  final res = await receivePort.first;
  print('location upload $res');
}
 */
Future<String> uploadPosition(
    Position position, bool serviceEnabled) async {
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
