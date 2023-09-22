import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/usecases/save_user_credentials_usecase.dart';
import 'package:family_guard/features/profile/domain/usecases/get_user_address_usecase.dart';
import 'package:family_guard/features/profile/domain/usecases/save_profile_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as lc;
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/widget/dialog_service.dart';

class ProfileProvider extends ChangeNotifier {
  UserEntity user = Provider.of<MainProvider>(Get.context!).userCredentials!;

  bool isUploadingImage = false;
  bool isLoadingUserAddree = false;
  bool isLogOut = false;
  AddressEntity? addressEntity;
  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  late GoogleMapController mapController;
  lc.Location location = lc.Location();
  late lc.PermissionStatus permissionGranted;
  late lc.LocationData locationData;
  late CameraPosition initialCameraPosition;

  initializeInitialCameraPosition() async {
    if (addressEntity == null) {
      return;
    }
    initialCameraPosition = CameraPosition(
      target: LatLng(addressEntity!.lat, addressEntity!.lon),
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
    if (addressEntity == null) {
      return;
    }
    // isCountryInRegion = false;
    // notifyListeners();
    mapController = await completer.future;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(addressEntity!.lat, addressEntity!.lon), 16));
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

  ProfileProvider() {
    log('Get address${user.apiToken!}');
    initializeInitialCameraPosition();

    getUserAddress();
  }

  void setUser(UserEntity u) {
    user = u;
    notifyListeners();
  }

  void changeProfileImage(XFile? image) async {
    Either<Failure, UserEntity> results = await sl<SaveProfileImageUsecase>()(
        SaveProfileImageParams(token: user.apiToken!, image: image!));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      user.setImageUrl = r.imageUrl;
      setUser(user);
      await sl<SaveUserCredentialsUsecase>()(user).then((value) =>
          Provider.of<MainProvider>(Get.context!, listen: false)
              .getCachedUserCredentials());
    });
    isUploadingImage = false;
    notifyListeners();
  }

  void openImages() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.mediaLibrary,
      //add more permission to request here.
    ].request();
    if (statuses[Permission.camera]!.isGranted) {
      if (statuses[Permission.storage]!.isGranted) {
        if (statuses[Permission.mediaLibrary]!.isGranted) {
          await DialogWidget.showCustomDialog(
              context: Get.context!,
              title: 'Select Image',
              buttonText: tr(AppConstants.ok),
              actions: [
                SizedBox(
                  height: 100,
                  child: isUploadingImage
                      ? Center(child: CustomLoadingIndicators.defaultLoading())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  isUploadingImage = true;
                                  await ImagePicker()
                                      .pickImage(source: ImageSource.gallery)
                                      .then(
                                          (value) => changeProfileImage(value));

                                  notifyListeners();
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.image,
                                  color: ThemeColorLight.pinkColor,
                                  size: 60,
                                )),
                            IconButton(
                                onPressed: () async {
                                  isUploadingImage = true;

                                  await ImagePicker()
                                      .pickImage(source: ImageSource.camera)
                                      .then(
                                          (value) => changeProfileImage(value));

                                  notifyListeners();
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.linked_camera,
                                  size: 60,
                                  color: ThemeColorLight.pinkColor,
                                )),
                          ],
                        ),
                ),
              ]);
        }
      }
    }
    notifyListeners();
  }

  void getUserAddress() async {
    log('Get address${user.apiToken!}');
    isLoadingUserAddree = true;
    Either<Failure, AddressEntity> results =
        await sl<GetUserAddressUsecase>()(user.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      addressEntity = r;
    });
    isLoadingUserAddree = false;
    notifyListeners();
  }

  void logoutUser(BuildContext context) async {
    isLogOut = true;
    notifyListeners();
    Provider.of<MainProvider>(context, listen: false)
        .logoutUser()
        .then((value) {
      isLogOut = false;
      notifyListeners();
    });
  }
}
