import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/usecases/check_mobile_registered_usecase.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';

import 'package:family_guard/features/authentication/presentation/screens/login_screen.dart';
import 'package:family_guard/features/authentication/presentation/utils/constants.dart';
import 'package:family_guard/features/authentication/presentation/utils/enums.dart';
import 'package:family_guard/features/general/presentation/screens/terms_and_privacy_policy.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/services/firebase_messaging_services.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';

import '../../../../core/widget/dialog_service.dart';
import '../../domain/entities/sign_up_params.dart';
import '../screens/verification_screen.dart';
import '../utils/utils.dart';
import '../validations/cancellation_reason_validation.dart';

class SignUpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String verificationsId = "";

  bool enableVerifyButton = false;
  bool showPassword = false;
  bool isUsingPhone = false;
  bool isTermsAndConditionsAccepted = false;
  bool isLoadingSignUp = false;
  bool isLoadingActiveCountries = false;
  bool isLoadingPhoneCodes = false;
  String? businessNameDuplicationError;

  FocusNode phoneFocus = FocusNode();

  ///Data

  Genders? selectedGenders;
  late SignUpParams _signUpParameters;

  ///Design related vars
  GlobalKey phoneCodePickerWidgetKey = GlobalKey();
  double textFieldHeight = 0.0;

  ///Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController commercialRegistrationController =
      TextEditingController();
  final TextEditingController maroofNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

//controller
  final TextEditingController facebookSocialMediaProfileController =
      TextEditingController();
  final TextEditingController instagramSocialMediaProfileController =
      TextEditingController();
  TextEditingController familyNameController = TextEditingController();

  bool firstNameShowValidation = false;
  bool lastNameShowValidation = false;
  bool familyNameShowValidation = false;
  bool emailOrPhoneShowValidation = false;
  bool businessNameShowValidation = false;
  bool commercialRegistrationShowValidation = false;
  bool maroofNumberShowValidation = false;
  bool passwordShowValidation = false;
  bool confirmPasswordShowValidation = false;
  bool facebookSocialMediaProfileShowValidation = false;
  bool instagramSocialMediaProfileShowValidation = false;

  String? countryCode;
  bool isloadingCountryCode = true;

  ///Sign up parameters

  SignUpProvider() {
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

  ///Validations

  String? validateFirstName(String firstName) {
    if (!firstNameShowValidation) return null;
    if (firstName.trim().length < 2) {
      return tr(AppConstants.firstNameMustBeAtLeast2Characters);
    } else if (!checkPattern(
        pattern: r'[a-zA-Zء-ي ]+$', value: firstName.trim())) {
      return tr(AppConstants.firstNameAcceptLettersOnly);
    }
    return null;
  }

  validateSecondName(String secondName) {
    if (!lastNameShowValidation) return null;
    if (secondName.trim().length < 2) {
      return tr(AppConstants.secondNameMustBeAtLeast2Characters);
    } else if (!checkPattern(
        pattern: r'[a-zA-Zء-ي ]+$', value: secondName.trim())) {
      return tr(AppConstants.secondNameAcceptLettersOnly);
    }
    return null;
  }

  validateFamilyName(String familyName) {
    if (!familyNameShowValidation) return null;
    if (familyName.trim().length < 2) {
      return tr(AppConstants.familyNameMustBeAtLeast2Characters);
    } else if (!checkPattern(
        pattern: r'[a-zA-Zء-ي ]+$', value: familyName.trim())) {
      return tr(AppConstants.familyNameAcceptLettersOnly);
    }
    return null;
  }

  ///
  validatePassword(String password) {
    if (!passwordShowValidation) return null;
    if (password.isEmpty) {
      return tr(AppConstants.passwordEmpty);
    } else if (password.length < passwordMinLength ||
        !passwordRegexChecker(password)) {
      return tr(AppConstants.passwordCriteriaInvalid);
    }
    return null;
  }

  validateConfirmPassword(String password) {
    if (!confirmPasswordShowValidation) return null;
    if (passwordController.text != confirmPasswordController.text) {
      return tr(AppConstants.passwordDoesntMatch);
    } else if (password.isEmpty) {
      return tr(AppConstants.passwordEmpty);
    } else if (password.length < passwordMinLength ||
        !passwordRegexChecker(password)) {
      return tr(AppConstants.passwordCriteriaInvalid);
    }
    return null;
  }

  ///Remove Validation If User Typed
  validateFirstNameOnChange(String value) {
    if (value.length > 1 && !firstNameShowValidation) return;
    firstNameShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateSecondNameOnChange(String value) {
    if (value.length > 1 && !lastNameShowValidation) return;
    lastNameShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateFamilyNameOnChange(String value) {
    if (value.length > 1 && !familyNameShowValidation) return;
    familyNameShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateMobilePhoneOnChange(String value) {
    if (value.length > 1 && !emailOrPhoneShowValidation) return;
    emailOrPhoneShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateBusinessNameOnChange(String value) {
    if (value.length > 1 && !businessNameShowValidation) return;
    businessNameShowValidation = false;
    businessNameDuplicationError = null;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateCommercialRegistrationOnChange(String value) {
    if (value.length > 1 && !commercialRegistrationShowValidation) return;
    commercialRegistrationShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateMaroofNumberOnChange(String value) {
    if (value.length > 1 && !maroofNumberShowValidation) return;
    maroofNumberShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validatePasswordOnChange(String value) {
    if (value.length > 1 && !passwordShowValidation) return;
    passwordShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  validateConfirmPasswordOnChange(String value) {
    if (value.length > 1 && !confirmPasswordShowValidation) return;
    confirmPasswordShowValidation = false;
    notifyListeners();
    formKey.currentState?.validate();
  }

  ///Validate If User Unfocused A Field

  validateFirstNameOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      firstNameShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateSecondNameOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      lastNameShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateFamilyNameOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      familyNameShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateEmailOrMobilePhoneOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      emailOrPhoneShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateBusinessNameOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      businessNameShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateCommercialRegistrationOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      commercialRegistrationShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateMaroofNumberOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      maroofNumberShowValidation = true;
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

  validateConfirmPasswordOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      confirmPasswordShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateFacebookSocialMediaProfileOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      facebookSocialMediaProfileShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  validateInstagramSocialMediaProfileOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      instagramSocialMediaProfileShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
      checkFormReadiness();
    }
  }

  ///
  ///
  void checkPhoneField(value) {
    isUsingPhone = checkPattern(pattern: r'[0-9]+$', value: value.trim());
    notifyListeners();
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

  ///Other functionalities
  void changePasswordState(bool state) {
    showPassword = state;
    notifyListeners();
  }

  void setSelectedGender(Genders gender) {
    selectedGenders = gender;
    notifyListeners();
    log(selectedGenders.toString());
    checkFormReadiness();
  }

  void setTermsAndConditionsState(bool state) {
    isTermsAndConditionsAccepted = state;
    checkFormReadiness();
    notifyListeners();
  }

  ///Check if form is ready to enable submit button and validate inputs
  void checkFormReadiness() {
    bool isNotValid = firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        familyNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        !isValidNumber(phoneNumber!) ||
        selectedGenders == null ||
        !isTermsAndConditionsAccepted ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty;
    if (enableVerifyButton != !isNotValid) {
      enableVerifyButton = !isNotValid;
      notifyListeners();
    }
  }

  void navigateToVerificationScreen() {}

  validateAndVerify() async {
    if (formKey.currentState!.validate()) {
      isLoadingSignUp = true;
      notifyListeners();
      Either<Failure, bool> results =
          await sl<CheckMobileRegisteredUsecase>()(phoneNumber!.completeNumber);
      results.fold((l) {
        isLoadingSignUp = false;
        DialogWidget.showCustomDialog(
          context: Get.context!,
          title: 'Please check the invalid data',
          buttonText: tr(AppConstants.ok),
        );
      }, (r) async {
        isLoadingSignUp = false;
        if (r) {
          DialogWidget.showCustomDialog(
              context: Get.context!,
              title: 'Already registered number, try sign in',
              buttonText: tr(AppConstants.signIn),
              onPressed: () {
                NavigationService.goBack();
                NavigationService.goBack();
              });
        } else {
          _signUpParameters = SignUpParams(
            firstName: firstNameController.text,
            secondName: lastNameController.text,
            familyName: familyNameController.text,
            mobile: phoneNumber!.completeNumber,
            email: "No Data",
            password: passwordController.text,
            gender: selectedGenders == Genders.male ? "0" : "1",
            uid: "No Data",
            token: (await sl<FirebaseMessagingServices>().deviceToken())!,
            platform: Platform.operatingSystem,
            imageUrl: "No Data",
            country: "",
            adminArea: "",
            subAdminArea: "",
            locality: "",
            subLocality: "",
            street: "",
            postalCode: "",
            lat: 0.0,
            lon: 0.0,
          );

          log(_signUpParameters.toJson().toString());
          NavigationService.navigateTo(
              navigationMethod: NavigationMethod.push,
              page: () => VerificationScreen(
                    signUpParams: _signUpParameters,
                  ));
        }
      });
    } else {
      isLoadingSignUp = false;
      DialogWidget.showCustomDialog(
          context: Get.context!,
          title: 'Please check the invalid data',
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
          });
    }
    notifyListeners();
  }

  goToSignInScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const LoginScreen());
  }

  goToTermsAndPrivacyPolicy() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const TermsAndPrivacyPolicyScreen());
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  PhoneNumber? phoneNumber;
  void setPhoneNumber(PhoneNumber phone) {
    phoneNumber = phone;
    log(isValidNumber(phoneNumber!).toString());
    checkFormReadiness();
  }
}
