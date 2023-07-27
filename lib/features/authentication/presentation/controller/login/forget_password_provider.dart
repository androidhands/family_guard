import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';




import '../../../../../core/global/localization/app_localization.dart';

import '../../../../../core/services/navigation_service.dart';
import '../../../../../core/utils/app_constants.dart';


import '../../validations/cancellation_reason_validation.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  ///Usecase

  

  ForgetPasswordProvider(sl
   
  ) {
    getTextFieldHeight();

  }

  final formKey = GlobalKey<FormState>();
  bool preventLettersInPhoneField = false;
  bool enableSendCodeButton = false;
  bool isUsingPhone = false;
  bool isLoadingSendCode = false;
  bool isLoadingPhoneCodes = false;



  final TextEditingController emailOrPhoneController = TextEditingController();
  late int tenantId;

  bool emailOrPhoneShowValidation = true;

  ///Design related vars
  final GlobalKey countryPickerWidgetKey = GlobalKey();
  double textFieldHeight = 0.0;

  getTextFieldHeight() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      textFieldHeight = countryPickerWidgetKey.currentContext!.size!.height;
      notifyListeners();
    });
  }

  String? validateEmailOrMobilePhone(String value) {
    if (!emailOrPhoneShowValidation) return null;
    if (value.isEmpty) {
      return tr(AppConstants.pleaseEnterAnEmailOrMobileNumber);
    } else if (value.startsWith(RegExp(r'[A-Z]|[a-z]'))) {
      String patternEmail =
          r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
      if (!checkPattern(pattern: patternEmail, value: value)) {
        return tr(AppConstants.emailIsNotCorrect);
      }
    } else if (value.startsWith(RegExp(r'[0-9]'))) {
    /*   if (selectedPhoneCode?.phoneCode == saPC) {
        Pattern patternMobileNumberSA = r'^5[5|0|3|6|4|9|1|8|7][0-9]{7,8}$';
        if (!checkPattern(pattern: patternMobileNumberSA, value: value)) {
          return tr(AppConstants.mobileNumberIsNotCorrect);
        }
      } else if (selectedPhoneCode?.phoneCode == egyPC) {
        Pattern patternMobileNumberEG = r'^1[0|1|2|5][0-9]{8}$';
        if (!checkPattern(pattern: patternMobileNumberEG, value: value)) {
          return tr(AppConstants.mobileNumberIsNotCorrect);
        }
      } else {
        if (value.length <
                getMinLengthFromPhoneCode(selectedPhoneCode?.phoneCode) ||
            value.length >
                getMaxLengthFromPhoneCode(selectedPhoneCode?.phoneCode)) {
          return tr(AppConstants.mobileNumberIsNotCorrect);
        }
      } */
    }
    notifyListeners();
    return null;
  }

  // String? validateEmailOrMobilePhone(String value) {
  //   if (!emailOrPhoneShowValidation) return null;
  //   if (value.isEmpty) {
  //     return tr(AppConstance.pleaseEnterAnEmailOrMobileNumber);
  //   } else if (value.startsWith(RegExp(r'[A-Z]|[a-z]'))) {
  //     String patternEmail =
  //         r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
  //     if (!checkPattern(pattern: patternEmail, value: value)) {
  //       return tr(AppConstance.emailIsNotCorrect);
  //     }
  //   } else if (value.startsWith(RegExp(r'[0-9]'))) {
  //     Pattern patternMobileNumberEG = r'^1[0|1|2|5][0-9]{8}$';
  //     Pattern patternMobileNumberSA = r'^5[5|0|3|6|4|9|1|8|7][0-9]{7,8}$';
  //     if (!checkPattern(pattern: patternMobileNumberEG, value: value) &&
  //         !checkPattern(pattern: patternMobileNumberSA, value: value)) {
  //       return tr(AppConstance.mobileNumberIsNotCorrect);
  //     }
  //   }
  //   notifyListeners();
  //   return null;
  // }

  validateEmailOrMobilePhoneOnChange(String value) {
    if (value.length > 1 && !emailOrPhoneShowValidation) return;
    emailOrPhoneShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateEmailOrMobilePhoneOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      emailOrPhoneShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
    }
  }

  void checkPhoneField(value) {
    if (value.startsWith(RegExp(r'[0-9]'))) {
      preventLettersInPhoneField = true;
      isUsingPhone = true;
    } else {
      preventLettersInPhoneField = false;
      isUsingPhone = false;
    }
    notifyListeners();
  }

  void backToLogin() {
    NavigationService.goBack();
  }

  Future<bool> checkIfUserIsBlocked() async {
  
    return false;
  }

 

 
  
}
