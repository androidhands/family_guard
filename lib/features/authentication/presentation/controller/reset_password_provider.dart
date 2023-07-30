import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';

import '../../../../core/widget/dialog_service.dart';

import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/save_user_credentials_usecase.dart';
import '../utils/constants.dart';

class ResetPasswordProvider with ChangeNotifier {
  ResetPasswordProvider();

  ///Use Case
  // ResetPasswordUseCase resetPasswordUseCase;

  ///controller
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ///onPress actions
  bool showPassword = false;
  bool showConfirmPassword = false;

  ///loading
  bool isLoadingResetPassword = false;

  bool passwordShowValidation = false;
  bool confirmPasswordShowValidation = false;
  bool enableVerifyButton = false;

  ///form
  final formKey = GlobalKey<FormState>();

  ///Other functionalities
  void changePasswordState(bool state) {
    showPassword = state;
    notifyListeners();
  }

  ///Check if form is ready to enable submit button and validate inputs
  void checkFormReadiness() {
    bool isNotValid = passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty;
    if (enableVerifyButton != !isNotValid) {
      enableVerifyButton = !isNotValid;
      notifyListeners();
    }
  }

  validatePasswordOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      passwordShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
    }
  }

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

  validateConfirmPasswordOnFocusLose(bool hasFocus) {
    if (!hasFocus) {
      confirmPasswordShowValidation = true;
      notifyListeners();
      formKey.currentState?.validate();
    }
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

  void changeConfirmPasswordState() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
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

  ///reset button
  void submit({required String phone, required String token}) async {
    passwordShowValidation = true;
    confirmPasswordShowValidation = true;
    if (formKey.currentState!.validate()) {
      isLoadingResetPassword = true;
      notifyListeners();
      (await sl<ResetPasswordUsecase>()(ResetPasswordParam(
              mobile: phone, token: token, password: passwordController.text)))
          .fold((l) async {
        isLoadingResetPassword = false;
        await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok),
        );
      }, (r) async {
        isLoadingResetPassword = false;

        (await sl<SaveUserCredentialsUsecase>()(r)).fold((l) async {
          await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: l.message,
            buttonText: tr(AppConstants.ok),
          );
        }, (r) async {
          await Provider.of<MainProvider>(Get.context!, listen: false)
              .getCachedUserCredentials()
              .then((value) {
            NavigationService.offAll(page: () => const HomeScreen());
          });
        });
      });

      notifyListeners();
    }
  }

  goBack() {
    NavigationService.popUntil(
        predicate: (route) => route.settings.name == '/ForgetPasswordScreen');
  }
}
