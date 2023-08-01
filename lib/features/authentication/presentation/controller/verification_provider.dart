import 'dart:async';
import 'dart:developer';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/services/number_parser.dart';
import 'package:family_guard/features/authentication/presentation/screens/location_detector_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widget/dialog_service.dart';
import '../../domain/entities/sign_up_params.dart';
import '../screens/signup_screen.dart';

class VerificationProvider with ChangeNotifier {
  bool isLoadingSubmitOtp = false;

  VerificationProvider({required this.signUpParams}) {
    initialization();
  }

  ///data
  final SignUpParams signUpParams;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///Timer Var
  bool timerIsRunning = true;
  final interval = const Duration(seconds: 1);
  int timerMaxSeconds = 120;
  int currentSeconds = 0;
  late Timer timer;
  bool isLoadingResendButton = false;

  int numResendClicked = 0;
  bool isBlocked = false;

  bool isLoading = true;
  bool mounted = true;
  String myVerificationId = "";

  ///pin code
  late String sentCode;
  final TextEditingController pinCodeController = TextEditingController();

  ///get Current Timer
  String get getTimerText {
    return (timerMaxSeconds - currentSeconds).numberParserToArabic();
  }

  initialization() async {
    verify();
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

  void verify() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: signUpParams.mobile,
        verificationCompleted: (PhoneAuthCredential credential) {
          log('verificationCompleted');
          _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) async {
          log('verificationFailed');
          log(e.message!);
          await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: e.message,
            buttonText: tr(AppConstants.ok),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          log('codeSent');
          myVerificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log('codeAutoRetrievalTimeout');
          myVerificationId = verificationId;
        },
        timeout: const Duration(seconds: 120));
  }

  Future<bool> verifyOtp(String otp, context) async {
    try {
      isLoadingSubmitOtp = true;
      notifyListeners();
      UserCredential credential = await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              smsCode: otp, verificationId: myVerificationId))
          .onError((error, stackTrace) async {
        log('verifications error');
        return await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: 'OTP Error',
          buttonText: tr(AppConstants.ok),
        );
      });

      return credential.user != null ? true : false;
    } on FirebaseAuthException catch (ex) {
      await DialogWidget.showCustomDialog(
        context: context,
        title: ex.message,
        buttonText: tr(AppConstants.ok),
      );
      isLoadingSubmitOtp = false;
      notifyListeners();
      return false;
    }
  }

  /// Resend Button
  Future<void> resendOnPress(context) async {
    if (numResendClicked < AppConstants.numBlockedVerification) {
      isLoadingResendButton = true;
      notifyListeners();
      numResendClicked++;
      verify();
      isLoadingResendButton = false;
      notifyListeners();
      currentSeconds = 0;
      timerIsRunning = true;
      startTimeout();
    } else {
      ///Blocked
      log('user blocked');
      await DialogWidget.showCustomDialog(
        context: context,
        barrierDismissible: false,
        title: tr(AppConstants.tooManyAttemptsPleaseTryAgainIn30Minutes),
        buttonText: tr(AppConstants.ok),
      );
    }
  }

  ///on Submit
  void onSubmit(context) async {
    bool verified = await verifyOtp(pinCodeController.text, context);
    if (verified) {
      log('Success');
      signUpParams.setUid = _auth.currentUser?.uid ?? "xccccdc";
      isLoadingSubmitOtp = false;
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement,
          page: () => LocationDetectorScreen(
                signUpParams: signUpParams,
              ));
    } else {
       log('not verified');
      isLoadingSubmitOtp = false;
      await DialogWidget.showCustomDialog(
          context: context,
          title: tr(AppConstants.incorrectOtpCode),
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
          });
    }
    notifyListeners();
  }

  ///on Complete Pin Code
  onComplete() async {
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
    timer.cancel();
    super.dispose();
  }
}
