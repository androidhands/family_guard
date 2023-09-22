import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/sign_up_params.dart';
import 'package:family_guard/features/home/presentation/screens/home_control_screen.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart' as gl;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/dialog_service.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/manual_sign_up_usecase.dart';
import '../../domain/usecases/save_user_credentials_usecase.dart';

class LocationDetectorProvider with ChangeNotifier {
  SignUpParams signUpParams;
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

  LocationDetectorProvider({required this.signUpParams}) {
    initializeInitialCameraPosition();

    // goToMyLocation();
  }

  initializeInitialCameraPosition() async {
    initialCameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
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

    /*    UserEntity? user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials; */
    locationTextController.text = address;
    signUpParams.setCountry =
        placemark.country == null || placemark.country!.isEmpty
            ? "No Country"
            : placemark.country!;
    signUpParams.setAdmimArea = placemark.administrativeArea == null ||
            placemark.administrativeArea!.isEmpty
        ? "No Admin Area"
        : placemark.administrativeArea!;
    signUpParams.setSubAdminArea = placemark.subAdministrativeArea == null ||
            placemark.subAdministrativeArea!.isEmpty
        ? "No Sub Admin Area"
        : placemark.subAdministrativeArea!;
    signUpParams.setLocality =
        placemark.locality == null || placemark.locality!.isEmpty
            ? "No Locality"
            : placemark.locality!;
    signUpParams.setSubLocality =
        placemark.subLocality == null || placemark.subLocality!.isEmpty
            ? "No Sub Locality"
            : placemark.subLocality!;
    signUpParams.setStreet =
        placemark.street == null || placemark.street!.isEmpty
            ? "No Street Name"
            : placemark.street!;
    signUpParams.setPostalCode =
        placemark.postalCode == null || placemark.postalCode!.isEmpty
            ? "No Postal Code"
            : placemark.postalCode!;
    signUpParams.setLat = coordinates.latitude;
    signUpParams.setLon = coordinates.longitude;

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
    notifyListeners();
    Either<Failure, UserEntity> results =
        await sl<ManualSignUpUsecase>()(signUpParams);
    results.fold((l) async {
      isSavingNewCountry = false;
      await DialogWidget.showCustomDialog(
          context: context,
          title: l.message,
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
          });
    }, (r) async {
      Either<Failure, bool> credentialsResult =
          await sl<SaveUserCredentialsUsecase>()(r);
      credentialsResult.fold((l) async {
        isSavingNewCountry = false;
        await DialogWidget.showCustomDialog(
            context: context,
            title: l.message,
            buttonText: tr(AppConstants.ok),
            onPressed: () {
              NavigationService.goBack();
            });
      }, (r) async {
        if (r) {
          isSavingNewCountry = false;
          NavigationService.offAll(page: () => const HomeControlScreen());
        } else {
          isSavingNewCountry = false;
          await DialogWidget.showCustomDialog(
              context: context,
              title: tr(AppConstants.failedSavingCredentials),
              buttonText: tr(AppConstants.ok),
              onPressed: () {
                NavigationService.goBack();
              });
        }
      });
    });

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
