import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/add_new_caller_id_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/add_new_caller_id_usecase.dart';
import 'package:family_guard/features/emergency/domain/usecases/check_verified_caller_id_usecase.dart';
import 'package:family_guard/features/emergency/presentation/screens/add_new_caller_id_screen.dart';
import 'package:family_guard/features/emergency/presentation/screens/emergency_call_screen.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:family_guard/features/profile/presentation/screens/my_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VerifyCallerIdProvider extends ChangeNotifier {
  VerifyCallerIdProvider({required this.verificationCode}) {}
  String verificationCode;
  late AddNewCallerIdEntity addNewCallerIdEntity;
  bool isloading = false;
  bool isCheckingCallerId = false;
  UserEntity userEntity =
      Provider.of<MainProvider>(Get.context!).userCredentials!;
  void addNewCallerId() async {
    isloading = true;
    notifyListeners();
    Either<Failure, AddNewCallerIdEntity> results =
        await sl<AddNewCallerIdUsecase>()(userEntity.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      addNewCallerIdEntity = r;
      verificationCode = r.validationCode;
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.push,
          page: () => AddNewCallerIdScreen(verifyCode: r.validationCode));
    });
    isloading = false;
    notifyListeners();
  }

  Future checkVeriviedCallerId() async {
    isloading = true;
    notifyListeners();
    Either<Failure, bool> isCallerIdVerfied =
        await sl<CheckVerifiedCallerIdUsecase>()(userEntity!.apiToken!);
    isCallerIdVerfied.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      log(r.toString());
      /* NavigationService.navigateTo(
          navigationMethod: NavigationMethod.push,
          page: () => const EmergencyCallScreen()); */
      if (r) {
        NavigationService.navigateTo(
            navigationMethod: NavigationMethod.push,
            page: () => const EmergencyCallScreen());
      } else {
        await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: 'Your phone is not verified, Resend a call again',
            buttonText: tr(AppConstants.ok),
            onPressed: () {
              addNewCallerId();
              Navigator.pop(Get.context!);
            });
      }
    });
    isloading = false;
    notifyListeners();
  }
}
