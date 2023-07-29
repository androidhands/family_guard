import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:family_guard/features/authentication/domain/usecases/check_verification_code_usecase.dart';
import 'package:family_guard/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:family_guard/core/services/number_parser.dart';
import 'package:get/get.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widget/dialog_service.dart';
import '../../domain/usecases/verify_user_phone_usecase.dart';
import '../screens/reset_password_screen.dart';
import '../utils/enums.dart';

class ForgetPasswordVerificationProvider with ChangeNotifier {
  ForgetPasswordVerificationProvider(
      {required this.phone, required this.channels}) {
    startTimeout();
  }

  ///data
  final String phone;
  Channels channels;

  ///Timer Var
  bool timerIsRunning = true;
  final interval = const Duration(seconds: 1);
  int timerMaxSeconds = 59;
  int currentSeconds = 0;
  late Timer timer;
  bool isLoadingResendButton = false;

  int numResendClicked = 0;
  bool isBlocked = false;

  bool isLoading = true;
  bool mounted = true;

  ///pin code
  final TextEditingController pinCodeController = TextEditingController();

  ///get Current Timer
  String get getTimerText {
    return (timerMaxSeconds - currentSeconds).numberParserToArabic();
  }

  ///Timer
  void startTimeout([int? milliseconds]) {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      if (timer.tick == timerMaxSeconds) timerIsRunning = false;
      currentSeconds = timer.tick;
      if (timer.tick >= timerMaxSeconds || !timerIsRunning) timer.cancel();
      notifyListeners();
    });
  }

  /// Resend Button
  Future<void> resendOnPress(context) async {
    resendVerificationPhoneNumber();
  }

  void resendVerificationPhoneNumber() async {
    isLoading = true;
    Either<Failure, String> results = await sl<VerifyUserPhoneUsecase>()(
        VerifyParams(phone: phone, channel: channels.name));
    results.fold((l) async {
      DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
          });
    }, (r) {});
    isLoading = false;
    notifyListeners();
  }

  ///on Submit
  void onSubmit(context) async {
    isLoading = true;

    Either<Failure, String> results = await sl<CheckVerificationCodeUsecase>()(
        CheckCodeParams(phone: phone, code: pinCodeController.text));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: context,
          title: tr(AppConstants.incorrectOtpCode),
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
          });
    }, (r) {
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement,
          page: ResetPasswordScreen(
            phone: phone,
            token: r,
          ));
    });
    isLoading = false;
    notifyListeners();
    /*  if (forgetPasswordVerificationEntity.sendCodeResultEntity.activationCode ==
        pinCodeController.text.encryptToSHA256()) {
      log('Success');
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement,
          page: () => ResetPasswordScreen(
            tenantId: forgetPasswordVerificationEntity.tenantId,
            sendCodeResultEntity:
            forgetPasswordVerificationEntity.sendCodeResultEntity,
          ));
    } else {
      await DialogWidget.showCustomDialog(
          context: context,
          title: tr(AppConstants.incorrectOtpCode),
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
          });
    } */
  }

  ///on Complete Pin Code
  Future<void> onComplete() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///on Change PinCode
  void onChangedPinCode() {
    notifyListeners();
  }

  ///is Enable Submit Button
  bool isEnableSubmitButton() {
    return pinCodeController.text.length == 6;
  }

  @override
  void notifyListeners() {
    if (mounted) super.notifyListeners();
  }

  @override
  void dispose() {
    mounted = false;
    pinCodeController.dispose();
    super.dispose();
  }
}
