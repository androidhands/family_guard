import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/data/models/address_model.dart';

import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/usecases/save_user_address_usecase.dart';
import 'package:family_guard/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart' as gl;
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/dialog_service.dart';
import '../../domain/entities/address_entity.dart';

class LocationDetectorProvider with ChangeNotifier {
  bool isLoadingLocation = true;
  bool isCountryInRegion = false;
  bool isSavingNewCountry = false;

  late CameraPosition initialCameraPosition;

  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  late GoogleMapController mapController;

  Location location = Location();
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  late AddressEntity addressEntity;

  final TextEditingController locationTextController = TextEditingController();

  String? selectedCountry;

  LocationDetectorProvider() {
    initializeInitialCameraPosition();

    // goToMyLocation();
  }

  initializeInitialCameraPosition() async {
    initialCameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    await Provider.of<MainProvider>(Get.context!, listen: false)
        .getCachedUserCredentials();
  }

  onMapCreated(GoogleMapController googleMapController) {
    if (!completer.isCompleted) {
      completer.complete(googleMapController);
    }
    notifyListeners();
  }

  changeLocation(BuildContext context) async {
    isCountryInRegion = false;
    isLoadingLocation = true;
    notifyListeners();

    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;

    double middleX = screenWidth / 2; // AppSizes.mapAddressHigh / 2;
    double middleY = AppSizes.mapAddressHigh / 2; //screenHeight / 2;

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
    selectedCountry = placemark.country;
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

    UserEntity? user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials;
    locationTextController.text = address;
    addressEntity = AddressModel(
        id: 0,
        mobile: user?.mobile ?? "",
        country: placemark.country ?? "",
        adminArea: placemark.administrativeArea ?? "",
        subAdminArea: placemark.subAdministrativeArea ?? "",
        locality: placemark.locality ?? "",
        subLocality: placemark.subLocality ?? "",
        street: placemark.street ?? "",
        postalCode: placemark.postalCode ?? "",
        updatedAt: '',
        createdAt: '');
    isLoadingLocation = false;
    notifyListeners();
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

  saveNewLocation(BuildContext context) async {
    isSavingNewCountry = true;

    Either<Failure, AddressEntity> results =
        await sl<SaveUserAddressUsecase>()(addressEntity);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: context,
          title: l.message,
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
          });
    }, (r) {
      NavigationService.offAll(page: () => const HomeScreen());
    });
    isSavingNewCountry = false;
    notifyListeners();
  }

  Future<bool> requestLocationPermission() async {
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
