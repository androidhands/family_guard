import 'dart:async';

import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart' as gl;
import 'package:location/location.dart';

import 'package:provider/provider.dart';

import '../../../authentication/domain/entities/user_entity.dart';

class HomeProvider extends ChangeNotifier {
  bool _disposed = false;
  @override
  void dispose() async {
    _disposed = true;
    mapController = await completer.future;
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
    initializeInitialCameraPosition();
    getAuthenticationResultModel();
  }

  UserEntity? userEntity;

  bool isLoadingLocation = true;
  bool isCountryInRegion = false;
  final TextEditingController locationTextController = TextEditingController();

  double middleX = 0.0;
  double middleY = 0.0;

  ///
  late CameraPosition initialCameraPosition;

  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  late GoogleMapController mapController;

  Location location = Location();
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  initializeInitialCameraPosition() async {
    initialCameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
  }

  Future<void> getAuthenticationResultModel() async {
    await Provider.of<MainProvider>(Get.context!, listen: false)
        .getCachedUserCredentials()
        .then((value) {
      userEntity = Provider.of<MainProvider>(Get.context!, listen: false)
          .userCredentials!;
      notifyListeners();
    });
  }

  onMapCreated(GoogleMapController googleMapController) {
    if (!completer.isCompleted) {
      completer.complete(googleMapController);
    }
    goToMyLocation();
  }

  goToMyLocation() async {
    isLoadingLocation = true;
    notifyListeners();
    if (!(await requestLocationPermission())) {
      isLoadingLocation = false;
      notifyListeners();
      return;
    }
    // isCountryInRegion = false;
    // notifyListeners();
    mapController = await completer.future;

    gl.Geolocator.getCurrentPosition(desiredAccuracy: gl.LocationAccuracy.best)
        .then((currentLocation) {
      mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(currentLocation.latitude, currentLocation.longitude), 16));
      isLoadingLocation = false;
      notifyListeners();
    });
  }

/* 
    permissionServiceCall() async {
    await permissionServices().then(
      (value) {
        if (value != null) {
          if (value[Permission.location]!.isGranted ) {
            /* ========= New Screen Added  ============= */

          
            
          }
        }
      },
    );
  }

  /*Permission services*/
  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,

      //add more permission to request here.
    ].request();

    if (statuses[Permission.location]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.location.status.isPermanentlyDenied == true &&
                await Permission.location.status.isGranted == false) {
              // openAppSettings();
              permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (statuses[Permission.location]!.isDenied) {
        permissionServiceCall();
      }
    }

    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  } */

  Future<bool> requestLocationPermission() async {
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied ||
        permissionGranted == PermissionStatus.grantedLimited) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      } else {
        permissionGranted = await location.requestPermission();
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
      address += '${placemark.country!}, ';
    }
    if (placemark.administrativeArea?.isNotEmpty ?? false) {
      address += '${placemark.administrativeArea!}, ';
    }
    if (placemark.subAdministrativeArea?.isNotEmpty ?? false) {
      address += '${placemark.subAdministrativeArea!}, ';
    }
    if (placemark.locality?.isNotEmpty ?? false) {
      address += '${placemark.locality!}, ';
    }
    if (placemark.subLocality?.isNotEmpty ?? false) {
      address += '${placemark.subLocality!}, ';
    }
    if (placemark.postalCode?.isNotEmpty ?? false) {
      address += '${placemark.postalCode!}, ';
    }
    if (placemark.street?.isNotEmpty ?? false) {
      address += '${placemark.street!}.';
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
}
