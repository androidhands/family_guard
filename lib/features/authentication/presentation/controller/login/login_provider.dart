import 'dart:developer';
import 'dart:io';

import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/services/firebase_messaging_services.dart';
import 'package:family_guard/features/authentication/domain/usecases/save_user_credentials_usecase.dart';
import 'package:family_guard/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:family_guard/features/authentication/presentation/screens/forget_password_screen.dart';

import 'package:family_guard/features/authentication/presentation/screens/signup_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

import '../../../../../core/global/localization/app_localization.dart';
import '../../../../../core/local_data/shared_preferences_services.dart';

import '../../../../../core/services/dependency_injection_service.dart';
import '../../../../../core/services/navigation_service.dart';
import '../../../../../core/utils/app_constants.dart';

import '../../../../../core/widget/dialog_service.dart';

import '../../../domain/entities/sign_in_params.dart';
import '../../../domain/usecases/manual_sign_in_usecase.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../validations/cancellation_reason_validation.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  // bool enableLoginButton = false;
  bool showPassword = false;
  bool isUsingPhone = false;
  bool isLoadingSignIn = false;
  bool isLoadingActiveCountries = true;

  bool isLoadingAvailableTenants = false;
  bool isLoadingPhoneCodes = false;
  bool showOrganization = false;
  bool enableVerifyButton = false;

  //isMounted .. Don't delete
  bool isMounted = true;
  String? countryCode;
  bool isloadingCountryCode = true;

  // SignIn Patamater
  late SignInParams _signInParameters;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool emailOrPhoneShowValidation = false;
  bool passwordShowValidation = false;

  ///Design related vars
  final GlobalKey phoneCodePickerWidgetKey = GlobalKey();
  double textFieldHeight = 0.0;

  FocusNode phoneFocus = FocusNode();

  LoginProvider() {
    init();
  }

  init() async {
    String? locale = await sl<SharedPreferencesServices>()
        .getData(key: AppConstants.userStoredLocale, dataType: DataType.string);
    if (locale == null) {
      String defaultLocale = Platform.localeName.split('_')[0];

      sl<BaseAppLocalizations>().changeLocale(languageCode: defaultLocale);
    } else {
      sl<BaseAppLocalizations>().changeLocale(languageCode: locale);
    }
    getCountryCode();
  }

  Future getCountryCode() async {
    try {
      countryCode = await FlutterSimCountryCode.simCountryCode;
      log(countryCode!);
    } on PlatformException {
      log('Failed to get sim country code.');
    }
    isloadingCountryCode = false;
    notifyListeners();
  }

  String? validateEmailOrMobilePhone(String value) {
    if (!emailOrPhoneShowValidation) return null;
    if (value.isEmpty) {
      return null; //tr(AppConstance.pleaseEnterAnEmailOrMobileNumber);
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
          return tr(AppConstance.mobileNumberIsNotCorrect);
        }
      } else if (selectedPhoneCode?.phoneCode == egyPC) {
        Pattern patternMobileNumberEG = r'^1[0|1|2|5][0-9]{8}$';
        if (!checkPattern(pattern: patternMobileNumberEG, value: value)) {
          return tr(AppConstance.mobileNumberIsNotCorrect);
        }
      } else {
        if (value.length <
                getMinLengthFromPhoneCode(selectedPhoneCode?.phoneCode) ||
            value.length >
                getMaxLengthFromPhoneCode(selectedPhoneCode?.phoneCode)) {
          return tr(AppConstance.mobileNumberIsNotCorrect);
        }
      } */
    }
    notifyListeners();
    return null;
  }

  void checkPhoneField(value) {
    isUsingPhone = checkPattern(pattern: r'[0-9]+$', value: value.trim());
    notifyListeners();
  }

  validatePassword(String password) {
    if (!passwordShowValidation) return null;
    if (password.isEmpty) {
      return null; // tr(AppConstance.passwordEmpty);
    } else if (password.length < passwordMinLength ||
        !passwordRegexChecker(password)) {
      return tr(AppConstants.passwordCriteriaInvalid);
    }

    return null;
  }

  bool passwordRegexChecker(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    // bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if ((hasUppercase || hasLowercase) &&
        hasDigits /* && hasSpecialCharacters*/) {
      return true;
    }
    return false;
  }

  ///Remove Validation If User Typed
  validateEmailOrMobilePhoneOnChange(String value) {
    if (value.length > 1 && !emailOrPhoneShowValidation) return;
    emailOrPhoneShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
    checkFormReadiness();
  }

  validatePasswordOnChange(String value) {
    if (value.length > 1 && !passwordShowValidation) return;
    passwordShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
    checkFormReadiness();
  }

  ///Remove Validation If User Typed

  ///Validate If User Unfocused A Field

  validateEmailOrMobilePhoneOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      emailOrPhoneShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validatePasswordOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      passwordShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  ///Other functionalities
  void changePasswordState(bool show) {
    showPassword = show;
    notifyListeners();
  }

  void checkFormReadiness() {
    bool isNotValid = phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        !isValidNumber(phoneNumber!);
    if (enableVerifyButton != !isNotValid) {
      enableVerifyButton = !isNotValid;
      notifyListeners();
    }
  }

  loginUser() async {
    isLoadingSignIn = true;
    notifyListeners();
    passwordShowValidation = true;
    emailOrPhoneShowValidation = true;
    if (formKey.currentState!.validate()) {
      _signInParameters = SignInParams(
          mobile: phoneNumber!.completeNumber,
          password: passwordController.text,
          token: (await sl<FirebaseMessagingServices>().deviceToken())!,
          platform: Platform.operatingSystem);
      var signInResults = await sl<ManualSignInUsecase>()(_signInParameters);
      signInResults.fold((l) async {
        await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok),
        );
      }, (r) async {
        (await sl<SaveUserCredentialsUsecase>()(r)).fold((l) async {
          await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: l.message,
            buttonText: tr(AppConstants.ok),
          );
        }, (r) async {
          await Provider.of<MainProvider>(Get.context!, listen: false)
              .getCachedUserCredentials()
              .then((value) => NavigationService.navigateTo(
                  navigationMethod: NavigationMethod.pushReplacement,
                  page: () => const HomeScreen()));
        });
      });
    }
    isLoadingSignIn = false;
    notifyListeners();
  }

  gotoSignUpScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const SignUpScreen());
  }

  gotoForgetPasswordScreen() {
    passwordController.clear();
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const ForgetPasswordScreen());
  }

  @override
  void notifyListeners() {
    if (isMounted) super.notifyListeners();
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  PhoneNumber? phoneNumber;
  void setPhoneNumber(PhoneNumber phone) {
    phoneNumber = phone;
    log(isValidNumber(phoneNumber!).toString());
    checkFormReadiness();
  }
}
