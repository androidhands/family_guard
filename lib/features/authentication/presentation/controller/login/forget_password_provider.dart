import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/usecases/verify_user_phone_usecase.dart';
import 'package:family_guard/features/authentication/presentation/screens/forget_password_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../../core/global/localization/app_localization.dart';
import '../../../../../core/services/dependency_injection_service.dart';
import '../../../../../core/services/navigation_service.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widget/dialog_service.dart';
import '../../utils/enums.dart';
import '../../utils/utils.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  ///Usecase

  ForgetPasswordProvider() {
    //getCountryCode();
  }

  final formKey = GlobalKey<FormState>();

  bool enableSendCodeButton = false;

  /// channneld
  Channels selectedChannel = Channels.sms;

  bool isLoadingSendCode = false;
  bool isLoadingPhoneCodes = false;
  String? countryCode;
  bool isloadingCountryCode = true;
  bool enableVerifyButton = false;

  final TextEditingController phoneController = TextEditingController();

  bool phoneShowValidation = true;

  ///Design related vars

/*   Future getCountryCode() async {
    try {
      countryCode = await FlutterSimCountryCode.simCountryCode;
      log(countryCode!);
    } on PlatformException {
      log('Failed to get sim country code.');
    }
    isloadingCountryCode = false;
    notifyListeners();
  } */

  PhoneNumber? phoneNumber;
  void setPhoneNumber(PhoneNumber phone) {
    phoneNumber = phone;
    log(isValidNumber(phoneNumber!).toString());
    checkFormReadiness();
  }

  void checkFormReadiness() {
    bool isNotValid =
        phoneController.text.isEmpty || !isValidNumber(phoneNumber!);
    if (enableVerifyButton != !isNotValid) {
      enableVerifyButton = !isNotValid;
      notifyListeners();
    }
  }

  validateEmailOrMobilePhoneOnChange(String value) {
    if (value.length > 1 && !phoneShowValidation) return;
    phoneShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateEmailOrMobilePhoneOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      phoneShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  void backToLogin() {
    NavigationService.goBack();
  }

  void verifyPhoneNumber() async {
    if (formKey.currentState!.validate()) {
      isLoadingPhoneCodes = true;
      notifyListeners();
      log('start sending');
      Either<Failure, String> results = await sl<VerifyUserPhoneUsecase>()(
          VerifyParams(
              phone: phoneNumber!.completeNumber,
              channel: selectedChannel.name));
      results.fold((l) async {
        DialogWidget.showCustomDialog(
            context: Get.context!,
            title: l.message,
            buttonText: tr(AppConstants.ok),
            onPressed: () {
              NavigationService.goBack();
            });
      }, (r) {
        NavigationService.navigateTo(
            navigationMethod: NavigationMethod.pushReplacement,
            page: () => ForgetPasswordVerificationScreen(
                  phone: phoneNumber!.completeNumber,
                  channels: selectedChannel,
                ));
      });
      isLoadingPhoneCodes = false;
      notifyListeners();
    }
  }

  void setSelectedChannel(Channels channels) {
    selectedChannel = channels;
    notifyListeners();
  }
}
