import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/get_calls_log_usecase.dart';
import 'package:family_guard/features/emergency/presentation/screens/call_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/background_dependency_injection.dart';

class CallsLogProvider extends ChangeNotifier {
  bool isLoading = false;
  List<PhoneCallEntity> phoneCalls = [];

  UserEntity user = Provider.of<MainProvider>(Get.context!).userCredentials!;
  CallsLogProvider() {
    getCallsLogBuUser();
  }
  void getCallsLogBuUser() async {
    isLoading = true;
    notifyListeners();
    Either<Failure, List<PhoneCallEntity>> results =
        await sl<GetCallsLogUsecase>()(user.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      phoneCalls = r;
    });

    isLoading = false;
    notifyListeners();
  }

  void navigateToCallDetailsScreen(PhoneCallEntity e) {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => CallDetailsScreen(phoneCallEntity: e));
  }
}
