import 'dart:async';
import 'dart:developer';

import 'package:family_guard/features/general/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:family_guard/core/services/number_parser.dart';


import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widget/dialog_service.dart';


import '../../domain/entities/forget_password_verification_entity.dart';
import '../screens/reset_password_screen.dart';

class ForgetPasswordVerificationProvider with ChangeNotifier {
  ForgetPasswordVerificationProvider({
    required this.forgetPasswordVerificationEntity,
  }) {
    startTimeout();
  }

  ///data
  ForgetPasswordVerificationEntity forgetPasswordVerificationEntity;
 

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
  /*   if (numResendClicked < AppConstants.numBlockedVerification) {
      isLoadingResendButton = true;
      notifyListeners();
      numResendClicked++;
      var result = forgetPasswordVerificationEntity.isPhone
          ? await sl<SendCodeForgetPasswordByPhoneUsecase>()(
              ForgetPasswordParameters(
                  forgetPasswordVerificationEntity.phoneCode! +
                      forgetPasswordVerificationEntity.emailOrPhone,
                  forgetPasswordVerificationEntity.tenantId))
          : await sl<SendCodeForgetPasswordByEmailUsecase>()(
              ForgetPasswordParameters(
                  forgetPasswordVerificationEntity.emailOrPhone,
                  forgetPasswordVerificationEntity.tenantId));
      result.fold((l) async {
        await DialogWidget.showCustomDialog(
          context: context,
          title: l.message,
          buttonText: tr(AppConstants.ok),
        );
        return;
      }, (r) async {
        forgetPasswordVerificationEntity = ForgetPasswordVerificationEntity(
            tenantId: forgetPasswordVerificationEntity.tenantId,
            emailOrPhone: forgetPasswordVerificationEntity.emailOrPhone,
            isPhone: forgetPasswordVerificationEntity.isPhone,
            sendCodeResultEntity: r,
            phoneCode: forgetPasswordVerificationEntity.phoneCode);
      });
      isLoadingResendButton = false;
      notifyListeners();
      currentSeconds = 0;
      timerIsRunning = true;
      startTimeout();
    } else {
      if (!isBlocked) {
        await SaveSpecificBlockedUser(baseBlockedUserRepository: sl()).call(
            forgetPasswordVerificationEntity.isPhone
                ? "${forgetPasswordVerificationEntity.phoneCode}${forgetPasswordVerificationEntity.emailOrPhone}"
                : forgetPasswordVerificationEntity.emailOrPhone);
        isBlocked = true;
      }

      ///Blocked
      await DialogWidget.showCustomDialog(
          context: context,
          barrierDismissible: false,
          title: tr(AppConstants.tooManyAttemptsPleaseTryAgainIn30Minutes),
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.navigateTo(
                navigationMethod: NavigationMethod.pushReplacement,
                page: () => const ForgetPasswordScreen());
          });
    } */
  }

  ///on Submit
  void onSubmit(context) async {
    if (forgetPasswordVerificationEntity.sendCodeResultEntity.activationCode ==
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
    }

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
    return pinCodeController.text.length == 4;
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
