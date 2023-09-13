import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/background_dependency_injection.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/make_emergency_call_usecase.dart';
import 'package:family_guard/features/emergency/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as gc;

class EmergencyCallsProvider extends ChangeNotifier {
  bool isLoading = false;
  UserEntity user = Provider.of<MainProvider>(Get.context!).userCredentials!;
  EmergencyTypes selectedEmergencyTypes = EmergencyTypes.Theif;
  setSelectedEmergencyType(EmergencyTypes emergencyTypes) {
    selectedEmergencyTypes = emergencyTypes;
    notifyListeners();
    makeEmergencyCall();
  }

  void makeEmergencyCall() async {
    isLoading = true;
    notifyListeners();
    bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();

    await gl.Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      gc.Placemark placemark = (await gc.placemarkFromCoordinates(
              position.latitude, position.longitude))
          .first;
      Either<Failure, PhoneCallEntity> results =
          await sl<MakeEmergencyCallUsecase>()(EmergencyCallParams(
              accessToken: user.apiToken!,
              emergencyCase: selectedEmergencyTypes.name,
              street: placemark.street == null || placemark.street!.isEmpty
                  ? "No Street Name Avaialable"
                  : placemark.street!.tr,
              state: placemark.administrativeArea == null ||
                      placemark.administrativeArea!.isEmpty
                  ? "No city name available"
                  : placemark.administrativeArea!.tr,
              city: placemark.subAdministrativeArea == null ||
                      placemark.subAdministrativeArea!.isEmpty
                  ? "No State Name available"
                  : placemark.subAdministrativeArea!.tr,
              country: placemark.country == null || placemark.country!.isEmpty
                  ? "No Country name availble"
                  : placemark.country!.tr,
              currentLat: position.latitude,
              currentLon: position.longitude));

      results.fold((l) async {
        await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: l.message,
            buttonText: tr(AppConstants.ok));
      }, (r) async {
        await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: 'Call has been sent to 911 successfully',
            buttonText: tr(AppConstants.ok));
      });

      isLoading = false;
      notifyListeners();
    }); /* .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
        isLoading = false;
      notifyListeners();
    }); */
  }
}
