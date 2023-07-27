

import 'dart:async';

import 'package:family_guard/core/services/number_parser.dart';
import 'package:flutter/material.dart';


class VerificationProvider with ChangeNotifier {
  VerificationProvider({required this.emailOrPhone, required this.isPhone}) {
    initialization();
  }

  ///data
  final String emailOrPhone;
  final bool isPhone;

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
  late String sentCode;
  final TextEditingController pinCodeController = TextEditingController();

  ///get Current Timer
  String get getTimerText {
    return (timerMaxSeconds - currentSeconds).numberParserToArabic();
  }

  initialization() async {
    if (isPhone) {
      await verifyMobileNumber();
    } else {
      await verifyEmail();
    }
    isLoading = false;
    notifyListeners();
    startTimeout();
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
    /* if (numResendClicked < AppConstants.numBlockedVerification) {
      isLoadingResendButton = true;
      notifyListeners();
      numResendClicked++;
      if (isPhone) {
        await verifyMobileNumber();
      } else {
        await verifyEmail();
      }
      isLoadingResendButton = false;
      notifyListeners();
      currentSeconds = 0;
      timerIsRunning = true;
      startTimeout();
    } else {
      if (!isBlocked) {
        await SaveSpecificBlockedUser(baseBlockedUserRepository: sl())
            .call(emailOrPhone);
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
                page: () => const SignUpScreen());
          });
    } */
  }

  ///on Submit
  void onSubmit(context) async {
    /* if (sentCode == pinCodeController.text.encryptToSHA256()) {
      log('Success');
      NavigationService.goBack(result: true);
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
  onComplete() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///verify Email
  Future<void> verifyEmail() async {
  /*   var result = await VerifyEmailUseCase(baseVerificationRepository: sl())
        .call(emailOrPhone);
    result.fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: l.message,
        buttonText: tr(AppConstants.ok),
      );
      NavigationService.goBack();
    }, (r) {
      sentCode = r;
    }); */
  }

  ///verify Email
  Future<void> verifyMobileNumber() async {
  /*   var result =
        await VerifyMobileNumberUseCase(baseVerificationRepository: sl())
            .call(emailOrPhone);
    result.fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: l.message,
        buttonText: tr(AppConstants.ok),
      );
      NavigationService.goBack();
    }, (r) {
      sentCode = r;
    }); */
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
    timer.cancel();
    super.dispose();
  }
}
