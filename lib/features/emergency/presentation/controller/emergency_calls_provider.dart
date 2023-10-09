import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/component/custom_drop_down_button.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_dark.dart';
import 'package:family_guard/core/services/background_dependency_injection.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/make_emergency_call_usecase.dart';
import 'package:family_guard/features/emergency/presentation/utils/utils.dart';
import 'package:family_guard/features/family/presentation/utils/members_utils.dart';
import 'package:family_guard/features/home/domain/usecases/track_my_members_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as gc;

class EmergencyCallsProvider extends ChangeNotifier {
  EmergencyCallsProvider() {
    collectMembersList();
  }
  bool isLoading = false;
  bool isLoadingMembers = false;
  UserEntity user = Provider.of<MainProvider>(Get.context!).userCredentials!;
  EmergencyTypes selectedEmergencyTypes = EmergencyTypes.Theif;
  String to = "";
  List<UserEntity> myMembers = [];
  late UserEntity selectedMember;
  setSelectedEmergencyType(
      EmergencyTypes emergencyTypes, BuildContext context) {
    selectedEmergencyTypes = emergencyTypes;
    notifyListeners();
    showMembersDialog(context);
    //  makeEmergencyCall();
  }

  void setSelectedMember(UserEntity userEntity) {
    selectedMember = userEntity;
  }

  void showMembersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomText('Request help from member',
              textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: ThemeColorDark.pinkColor, fontSize: AppSizes.h4)),
          content: Container(
            height: AppSizes.mapAddressHight2,
            child: Center(
              child: Column(children: [
                CustomText('Select your member',
                    textStyle: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(
                            color: ThemeColorDark.pinkColor,
                            fontSize: AppSizes.h6)),
                SizedBox(
                  height: AppSizes.pH1,
                ),
                CustomDropDownButton(
                  title:
                      '${selectedMember.firstName}  ${selectedMember.mobile}',
                  height: AppSizes.dropDownButtonSize,
                  onClick: () {
                    showMembersDropDwonDialog((u) {
                      setSelectedMember(u);
                    }, myMembers,
                        '${selectedMember.firstName}  ${selectedMember.mobile}');
                  },
                ),
                SizedBox(
                  height: AppSizes.pH3,
                ),
                CustomElevatedButton(
                    onPressed: () {
                      makeEmergencyCall();
                      NavigationService.goBack();
                    },
                    text: tr(AppConstants.sendHelpRequest))
              ]),
            ),
          ),
        );
      },
    );
  }

  void collectMembersList() async {
    isLoadingMembers = true;
    Either<Failure, List<UserEntity>> results =
        await sl<TrackMyMembersUsecase>()(user.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      log('tracked users ${jsonEncode(r)}');
      myMembers = r;
      if (r.isNotEmpty) {
        setSelectedMember(r[0]);
      }
    });
    isLoadingMembers = false;
    notifyListeners();
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
              currentLon: position.longitude,
              to: selectedMember.mobile));

      results.fold((l) async {
        await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: l.message,
            buttonText: tr(AppConstants.ok));
      }, (r) async {
        await DialogWidget.showCustomDialog(
            context: Get.context!,
            title:
                'The Call has been sent to ${selectedMember.firstName} successfully',
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
