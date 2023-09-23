import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:background_location/background_location.dart' as bGl;
import 'package:family_guard/core/services/background_location_service.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/map_utils.dart';
import 'package:family_guard/core/utils/utils.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/data/models/user_model.dart';
import 'package:family_guard/features/home/data/datasource/tracking_data_source.dart';
import 'package:family_guard/features/home/data/models/tracking_model.dart';
import 'package:family_guard/features/home/data/repository/tracking_repository.dart';
import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:family_guard/features/home/domain/usecases/track_my_members_usecase.dart';
import 'package:family_guard/features/home/utils/utils.dart';
import 'package:family_guard/features/notifications/domain/usecases/get_notification_count_usecase.dart';
import 'package:family_guard/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:family_guard/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart' as gl;
import 'package:location/location.dart' as lc;

import 'package:provider/provider.dart';

import '../../../authentication/domain/entities/user_entity.dart';

class HomeProvider extends ChangeNotifier {
  bool _disposed = false;
  int notificationCount = 0;
  bool isServiceEnabled = false;
  @override
  void dispose() async {
    log('home provider disposes');
    _disposed = true;
    // mapController = await completer.future;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  ///constructor
  HomeProvider() {
    // LocationFetcher.instance.getLocation();

    initializeInitialCameraPosition();
    getAuthenticationResultModel();
    if (Platform.isIOS) {
      fetchBackgroundLocation();
    }

    Future.delayed(const Duration(seconds: 2), getUnReadNotificationCount);
  }
  void fetchBackgroundLocation() async {
    log('start fetching');
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(888, 'Family Guard',
        'Family Guard updating your location', NotificationDetails());
    await location.enableBackgroundMode(enable: true);

    await location.changeNotificationOptions(
      channelName: 'my_foreground',
      title: 'Family Guard',
      subtitle: 'Family Guard updating your location',
      iconName: 'ic_bg_service_small',
    );
    await location.changeSettings(
        interval: 600000, accuracy: lc.LocationAccuracy.high);
    location.onLocationChanged.listen((position) async {
      // log('start fetching location ${jsonEncode(position)}');
      // Fluttertoast.showToast(msg: position.latitude.toString());
      gc.Placemark placemark = (await gc.placemarkFromCoordinates(
              position.latitude!, position.longitude!))
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
        subLocality:
            placemark.subLocality == null || placemark.subLocality!.isEmpty
                ? "No Sub Locality"
                : placemark.subLocality!.tr,
        street: placemark.street == null || placemark.street!.isEmpty
            ? "No Street Name"
            : placemark.street!.tr,
        postalCode:
            placemark.postalCode == null || placemark.postalCode!.isEmpty
                ? "No Postal Code"
                : placemark.postalCode!,
        lat: position.latitude!,
        lon: position.longitude!,
        speed: position.speed == 0.0 || position.speed! < 0.0
            ? 0.0001
            : position.speed!,
      );
      /*  location.changeNotificationOptions(
            title: 'Family Guard',
            subtitle: 'Geolocation detection ${currentLocation.latitude}',
            iconName: 'ic_bg_service_small'); */

      try {
        Either<Failure, String> results = await AddNewUserLocationUsecase(
            baseTrackingRepository: TrackingRepository(
                baseTrackingDataSource: TrackingDataSource()))(TrackingParams(
            accessToken: userEntity!.apiToken!,
            trackingEntity: trackingEntity));
        results.fold((l) {
          log('Service locations error ${l.message}');
        }, (r) {
          log('Service locations $r');
        });
      } catch (e) {
        log('Location Fetcher error ${e.toString()}');
      }
    });
  }

  UserEntity? userEntity =
      Provider.of<MainProvider>(Get.context!, listen: false).userCredentials;

  bool isLoadingLocation = true;
  bool isCountryInRegion = false;
  final TextEditingController locationTextController = TextEditingController();

  double middleX = 0.0;
  double middleY = 0.0;

  ///
  late CameraPosition initialCameraPosition;

  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  late GoogleMapController mapController;

  lc.Location location = lc.Location();
  late lc.PermissionStatus permissionGranted;
  late lc.LocationData locationData;

  initializeInitialCameraPosition() async {
    initialCameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    await gl.Geolocator.isLocationServiceEnabled();
    await goToMyLocation();
  }

  Future<void> getAuthenticationResultModel() async {
    await Provider.of<MainProvider>(Get.context!, listen: false)
        .getCachedUserCredentials()
        .then((value) {
      notifyListeners();
    });
    // await initializeBackroundService();
  }

  onMapCreated(GoogleMapController googleMapController) {
    if (!completer.isCompleted) {
      completer.complete(googleMapController);
    }
    notifyListeners();
  }

  goToMyLocation() async {
    log('Go to my location');
    isLoadingLocation = true;
    notifyListeners();

    if (!await requestLocationPermission()) {
      isLoadingLocation = false;
      notifyListeners();
      return;
    }

    if (!await handleLocationPermission()) {
      isLoadingLocation = false;
      notifyListeners();
      return;
    }

    // isCountryInRegion = false;
    // notifyListeners();
    mapController = await completer.future;

    gl.Geolocator.getCurrentPosition(desiredAccuracy: gl.LocationAccuracy.best)
        .then((currentLocation) async {
      mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(currentLocation.latitude, currentLocation.longitude), 16));

      isLoadingLocation = false;
      notifyListeners();
    }).catchError((error) {
      log(error.toString());
      isLoadingLocation = false;
      notifyListeners();
    });
  }

  Future<bool> requestLocationPermission() async {
    permissionGranted = await location.hasPermission();
    if (permissionGranted == lc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != lc.PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  changeLocation(BuildContext context) async {
    isCountryInRegion = false;
    isLoadingLocation = true;
    notifyListeners();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    middleX = screenWidth / 2;
    middleY = screenHeight / 2;

    ScreenCoordinate screenCoordinate =
        ScreenCoordinate(x: middleX.round(), y: middleY.round());
    mapController = await completer.future;

    LatLng coordinates = await mapController.getLatLng(screenCoordinate);
    gc.Placemark placemark = (await gc.placemarkFromCoordinates(
            coordinates.latitude, coordinates.longitude))
        .first;
    isCountryInRegion = true;
    /* placemark.country == AppConstants.geoCoderCountryEgypt ||
            placemark.country == AppConstants.geoCoderCountrySA; */
    //  selectedCountry = placemark.country;
    String address = '';
    if (placemark.country?.isNotEmpty ?? false) {
      address += '${placemark.country!.tr}, ';
    }
    if (placemark.administrativeArea?.isNotEmpty ?? false) {
      address += '${placemark.administrativeArea!.tr}, ';
    }
    if (placemark.subAdministrativeArea?.isNotEmpty ?? false) {
      address += '${placemark.subAdministrativeArea!.tr}, ';
    }
    if (placemark.locality?.isNotEmpty ?? false) {
      address += '${placemark.locality!.tr}, ';
    }
    if (placemark.subLocality?.isNotEmpty ?? false) {
      address += '${placemark.subLocality!.tr}, ';
    }
    if (placemark.postalCode?.isNotEmpty ?? false) {
      address += '${placemark.postalCode!}, ';
    }
    if (placemark.street?.isNotEmpty ?? false) {
      address += '${placemark.street!.tr}.';
    }

    /*    UserEntity? user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials; */
    locationTextController.text = address;

    isLoadingLocation = false;
    notifyListeners();
  }

  void navigateToNotificationScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const NotificationsScreen());
  }

  void navigateToProfileScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const ProfileScreen());
  }

  void getUnReadNotificationCount() async {
    isLoadingLocation = true;
    Either<Failure, int> result =
        await sl<GetNotificationCountUseCase>()(userEntity!.apiToken!);
    result.fold((l) {
      log('notification count error${l.message}');
    }, (r) => notificationCount = r);
    notifyListeners();
  }

  ///Timer Var
  bool timerIsRunning = false;
  final interval = const Duration(seconds: 1);
  int timerMaxSeconds = 30;
  int currentSeconds = 0;
  late Timer timer;
  bool firstClick = false;
  bool isTrackingMembers = false;
  List<UserEntity> trackedmembers = [];
  Set<Polyline> polyLines = {};
  HashSet<Marker> membersMarkers = HashSet<Marker>();

  setFirstClick() {
    firstClick = !firstClick;
    if (!firstClick) {
      membersMarkers.clear();
      goToMyLocation();
    }
    notifyListeners();
  }

  ///Timer
  void startTimeout([int? milliseconds]) {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (firstClick == false) {
        timer.cancel();
        return;
      }
      trackMyMembers();
    });
  }

  void trackMyMembers() async {
    log('start tracking');
    if (!firstClick) {
      return;
    }
    isTrackingMembers = true;
    notifyListeners();
    Either<Failure, List<UserEntity>> results =
        await sl<TrackMyMembersUsecase>()(userEntity!.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      log('tracked users ${jsonEncode(r)}');
      trackedmembers = r;
      startTimeout();
      if (r.isNotEmpty) {
        await showMembersOmMap(r);
      }
    });

    /*    Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (!isTrackingMembers) {
        timer.cancel();
      }

    }); */
  }

  Future showMembersOmMap(List<UserEntity> list) async {
    log('show marker');
    List<LatLng> latLangList = [];
    membersMarkers.clear();
    for (UserEntity u in list) {
      latLangList.add(LatLng(u.trackingEntity!.lat, u.trackingEntity!.lon));
      membersMarkers.add(Marker(
          draggable: false,
          markerId: MarkerId("${u.id}"),
          position: LatLng(u.trackingEntity!.lat, u.trackingEntity!.lon),
          icon:
              await getMarkerIcon(u.imageUrl, Size(200.w, 200.h), u.firstName),
          infoWindow: InfoWindow(
              title: u.userName,
              snippet: 'Updated At: ${u.trackingEntity!.updatedAt}')));
      log('marker added');
    }

    mapController.moveCamera(
      CameraUpdate.newLatLngBounds(
        MapUtils.boundsFromLatLngList(latLangList),
        4.0,
      ),
    );

    var centerPoint = computeCentroid(latLangList);

    var zoom = await mapController.getZoomLevel();

    updateLocation(centerPoint.latitude, centerPoint.longitude, zoom - 2);
    notifyListeners();
  }

  LatLng computeCentroid(Iterable<LatLng> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    for (LatLng point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / n, longitude / n);
  }

  updateLocation(double latitude, double longitude, double zoom) async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(latitude, longitude),
        zoom: zoom,
      ),
    ));
    isTrackingMembers = false;
    notifyListeners();
  }

  /*  Future<BitmapDescriptor> getMarkerIcon(
    String imageUrl,GlobalKey globalKey
  ) async {
 //   GlobalKey globalKey = GlobalKey(debugLabel: imageUrl);
    WidgetToImage(
      builder: (key) {
        globalKey = key;
        return MarkerWidget(
            imageUrl: imageUrl, accessToken: userEntity!.apiToken!);
      },
    );

    final RenderObject? boundary =
        globalKey.currentContext!.findRenderObject();

    ///repaintBoundary.createRenderObject(Get.context!);
    /*   if (boundary.debugNeedsPaint) {
      Timer(Duration(seconds: 1), () => getMarkerIcon(imageUrl));
     
    } */
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(pngBytes);
    /*   ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    var painter = CustomGuardShape();
    var size = Size(150.w, 150.h);

    painter.paint(canvas, size);
    ui.Image renderedImage = await recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());

    var pngBytes =
        await renderedImage.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List uint8List = pngBytes!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List); */
  } */
}
