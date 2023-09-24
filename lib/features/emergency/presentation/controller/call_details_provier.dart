import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/get_call_log_by_sid_usecase.dart';
import 'package:family_guard/features/emergency/domain/usecases/get_call_record_url_usecase.dart';
import 'package:flutter/material.dart';

import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart' as lc;
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/services/background_dependency_injection.dart';

class CallDetailsProvier extends ChangeNotifier {
  PhoneCallEntity phoneCallEntity;
  CallDetailsProvier({
    required this.phoneCallEntity,
  }) {
    getCallDetails();
  }
  late PhoneCallEntity callEntity;
  late String recordUrl;
  UserEntity user = Provider.of<MainProvider>(Get.context!).userCredentials!;
  bool isLoading = false;
  bool isGettingRecordingUrl = false;

  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  late GoogleMapController mapController;
  lc.Location location = lc.Location();
  late lc.PermissionStatus permissionGranted;
  late lc.LocationData locationData;
  late CameraPosition initialCameraPosition;
  void getCallDetails() async {
    isLoading = true;
    notifyListeners();
    Either<Failure, PhoneCallEntity> results =
        await sl<GetCallLogBySidUsecase>()(
            CallLogParams(user.apiToken!, phoneCallEntity.sid!));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      callEntity = r;
      initializeInitialCameraPosition();
      getRecordUrl();
    });
    isLoading = false;
    notifyListeners();
  }

  initializeInitialCameraPosition() async {
    initialCameraPosition = CameraPosition(
      target: LatLng(phoneCallEntity.lat, phoneCallEntity.lon),
      zoom: 14.4746,
    );
    await goToMyLocation();
  }

  onMapCreated(GoogleMapController googleMapController) {
    if (!completer.isCompleted) {
      completer.complete(googleMapController);
    }
    goToMyLocation();
    notifyListeners();
  }

  goToMyLocation() async {
    log('Go to my location');

    notifyListeners();
    if (!(await requestLocationPermission())) {
      notifyListeners();
      return;
    }
    // isCountryInRegion = false;
    // notifyListeners();
    mapController = await completer.future;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(phoneCallEntity.lat, phoneCallEntity.lon), 16));
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

  void getRecordUrl() async {
    isGettingRecordingUrl = true;
    Either<Failure, String> results = await sl<GetCallRecordUrlUsecase>()(
        CallLogParams(user.apiToken!, phoneCallEntity.sid!));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      recordUrl = r;
    });
    isGettingRecordingUrl = false;
    notifyListeners();
  }
}
