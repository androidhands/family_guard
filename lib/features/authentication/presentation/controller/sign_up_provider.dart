import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';

import 'package:family_guard/features/authentication/presentation/screens/login_screen.dart';
import 'package:family_guard/features/authentication/presentation/utils/constants.dart';
import 'package:family_guard/features/authentication/presentation/utils/enums.dart';
import 'package:family_guard/features/general/presentation/screens/terms_and_privacy_policy.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';

import '../validations/cancellation_reason_validation.dart';

class SignUpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  bool enableVerifyButton = false;
  bool showPassword = false;
  bool isUsingPhone = false;
  bool isTermsAndConditionsAccepted = false;
  bool isLoadingSignUp = false;
  bool isLoadingActiveCountries = false;
  bool isLoadingPhoneCodes = false;
  String? businessNameDuplicationError;

  ///Data

  List<Genders> selectedGenders = [];

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

  ///Sign up parameters
  // late SignUpParameters _signUpParameters;

  ///Design related vars
  GlobalKey phoneCodePickerWidgetKey = GlobalKey();
  double textFieldHeight = 0.0;

  SignUpProvider();

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
      /*  if (selectedPhoneCode?.phoneCode == saPC) {
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
    if (selectedGenders.any((element) => element == gender)) {
      selectedGenders.remove(gender);
    } else {
      selectedGenders.add(gender);
    }
    checkFormReadiness();
    notifyListeners();
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
        selectedGenders.isEmpty ||
        !isTermsAndConditionsAccepted ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty;
    if (enableVerifyButton != !isNotValid) {
      enableVerifyButton = !isNotValid;
      notifyListeners();
    }
  }

/*   Future<bool> checkIfUserIsBlocked() async {
    var result =
        await VerifySpecificBlockedUser(baseBlockedUserRepository: sl()).call(
            isUsingPhone
                ? ( emailOrPhoneController.text)
                : emailOrPhoneController.text);
    late bool isBlocked = false;
    result.fold((l) {
      isBlocked = false;
    }, (r) {
      isBlocked = r;
    });
    return isBlocked;
  } */

  void verify() async {
    /*  bool isBlocked = await checkIfUserIsBlocked();
    if (isBlocked) {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: tr(AppConstants.tooManyAttemptsPleaseTryAgainIn30Minutes),
        buttonText: tr(AppConstants.ok),
      );
    } else {
      validateAndVerify();
    } */
  }

  /* Future<bool> checkCredentialsExistence() async {
    Either<Failure, bool> result;
    bool isAllowed = false;
    result =
        await checkBusinessNameExistenceUseCase((businessNameController.text));
    result.fold((l) async {
      isAllowed = false;
      businessNameDuplicationError = l.message;
    }, (r) {
      businessNameDuplicationError = null;
      isAllowed = true;
    });
    return isAllowed;
  } */

  validateAndVerify() async {
    /*  _signUpParameters = SignUpParameters(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      emailAddress: isUsingPhone ? null : emailOrPhoneController.text,
      deviceToken: (await sl<FirebaseMessagingServices>().deviceToken())!,
      confirmPassword: confirmPasswordController.text,
      isAutomaticSignIn: true,
      isEmailConfirmed: !isUsingPhone,
      isPhoneConfirmed: isUsingPhone,
      password: passwordController.text,
      mobileNumber: isUsingPhone ? emailOrPhoneController.text : null,
      phoneCode: '',
      countryCode:
      '',
      phoneCodeCountryId:0,
      countryId:1,
      targetAudience: selectedGenders.map((e) => e.index).toList(),
      typeId: 0,
      maroofNumber: maroofNumberController.text,
      businessName: businessNameController.text,
      commercialRegistration: commercialRegistrationController.text,
      facebookLink: facebookSocialMediaProfileController.text,
      instagramLink: instagramSocialMediaProfileController.text,
    );

    firstNameShowValidation = true;
    lastNameShowValidation = true;
    businessNameShowValidation = true;
    commercialRegistrationShowValidation = true;
    maroofNumberShowValidation = true;
    emailOrPhoneShowValidation = true;
    passwordShowValidation = true;
    confirmPasswordShowValidation = true;

    bool isCredentialsAlreadyExist = await checkCredentialsExistence();
    if (formKey.currentState!.validate()) {
      if (isCredentialsAlreadyExist) {
        String emailOrPhone = isUsingPhone
            ? (emailOrPhoneController.text)
            : emailOrPhoneController.text;
        passwordController.clear();
        confirmPasswordController.clear();
        bool? isVerified = await NavigationService.navigateTo(
            navigationMethod: NavigationMethod.push,
            page: () => VerificationScreen(
                  emailOrPhone: emailOrPhone,
                  isPhone: isUsingPhone,
                ));

        if (isVerified ?? false) {
          await submitSignUp();
        }
      }
    } */
  }

  submitSignUp() async {
    /*  isLoadingSignUp = true;
    notifyListeners();
    var res = await manualSignUpUseCase.call(_signUpParameters);
    res.fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: tr(l.message),
        buttonText: tr(AppConstants.ok),
      );
      isLoadingSignUp = false;
      notifyListeners();
    }, (r) async {
      await saveAuthCredentialUseCase.call(AuthenticationResultParams(
          accessToken: r.accessToken,
          encryptedAccessToken: r.encryptedAccessToken,
          expireInSeconds: r.expireInSeconds,
          userId: r.userId,
          thumbImageUrl: r.thumbImageUrl,
          profileImageUrl: r.profileImageUrl,
          fullName: r.fullName));
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement,
          page: () => const HomeControlScreen());
    }); */
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

  validateForm() {
    /*  formKey.currentState!.validate();
    if (businessNameDuplicationError != null) {
      checkCredentialsExistence().then((_) {
        formKey.currentState!.validate();
      });
    } */
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  PhoneNumber? phoneNumber;
  void setPhoneNumber(PhoneNumber phone) {
    phoneNumber = phone;
    log(phoneNumber!.completeNumber);
  }
}
