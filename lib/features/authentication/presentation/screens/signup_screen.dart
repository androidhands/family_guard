import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';

import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_check_box.dart';
import 'package:family_guard/core/widget/custom_links.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/text_form_field/custom_text_form_field.dart';
import 'package:family_guard/features/authentication/presentation/components/authentication_common_body.dart';
import 'package:family_guard/features/authentication/presentation/components/choose_gender_components.dart';

import 'package:family_guard/features/authentication/presentation/controller/sign_up_provider.dart';
import 'package:family_guard/features/authentication/presentation/utils/constants.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:provider/provider.dart';

import '../../../../core/global/theme/theme_color/theme_color_light.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*     (sl<FirebaseMessagingServices>().deviceToken())
        .then((value) => log(value!));
 */
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      child: Consumer<SignUpProvider>(
        builder: (context, provider, child) {
          return AuthenticationCommonBody(
            isScrolling: true,
            backOnPress: () => NavigationService.goBack(),
            title: tr(AppConstants.signUp),
            body: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  /*  AuthenticationHeader(
                    title: tr(AppConstants.signUp),
                    subTitle: tr(AppConstants.yourSocialCampaigns),
                    isSignIn: false,
                  ), */

                  CustomText.primaryBodyLarge(
                    tr(AppConstants.signUp),
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: AppSizes.h4,
                        ),
                  ),
                  SizedBox(
                    height: AppSizes.pH1,
                  ),
                  CustomText.secondaryDisplaySmall(
                    tr(AppConstants.withPhomeNumber),
                    textStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: AppSizes.h7,
                            ),
                  ),
                  SizedBox(
                    height: AppSizes.pH9,
                  ),
                  CustomTextFormField(
                      onFocusChange: (hasFocus) =>
                          provider.validateFirstNameOnFocusLose(hasFocus),
                      controller: provider.firstNameController,
                      labelText: tr(AppConstants.firstName),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp("[a-zA-Zء-ي ]")),
                      // ],
                      validator: (firstName) =>
                          provider.validateFirstName(firstName!),
                      maxLength: nameMaxDigits,
                      onChanged: (value) {
                        provider.checkFormReadiness();
                        provider.validateFirstNameOnChange(value);
                      }),
                  SizedBox(
                    height: AppSizes.pH3,
                  ),
                  CustomTextFormField(
                      onFocusChange: (hasFocus) =>
                          provider.validateSecondNameOnFocusLose(hasFocus),
                      controller: provider.lastNameController,
                      labelText: tr(AppConstants.lastName),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp("[a-zA-Zء-ي ]")),
                      // ],
                      validator: (lastName) =>
                          provider.validateSecondName(lastName!),
                      maxLength: nameMaxDigits,
                      onChanged: (value) {
                        provider.checkFormReadiness();
                        provider.validateSecondNameOnChange(value);
                      }),
                  SizedBox(
                    height: AppSizes.pH3,
                  ),
                  CustomTextFormField(
                      onFocusChange: (hasFocus) =>
                          provider.validateFamilyNameOnFocusLose(hasFocus),
                      controller: provider.familyNameController,
                      labelText: tr(AppConstants.familyName),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp("[a-zA-Zء-ي ]")),
                      // ],
                      validator: (lastName) =>
                          provider.validateFamilyName(lastName!),
                      maxLength: nameMaxDigits,
                      onChanged: (value) {
                        provider.checkFormReadiness();
                        provider.validateFamilyNameOnChange(value);
                      }),
                  SizedBox(
                    height: AppSizes.pH3,
                  ),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: tr(AppConstants.phoneNumber),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    dropdownIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: ThemeColorLight.pinkColor,
                    ),
                    initialCountryCode: provider.countryCode,
                    controller: provider.phoneController,
                    onChanged: (phone) {
                      provider.setPhoneNumber(phone);
                      provider.checkFormReadiness();
                    },
                  ),
                  SizedBox(
                    height: AppSizes.pH3,
                  ),
                  CustomTextFormField(
                      onFocusChange: (hasFocus) =>
                          provider.validatePasswordOnFocusLose(hasFocus),
                      controller: provider.passwordController,
                      labelText: tr(AppConstants.password),
                      obscureText: !provider.showPassword,
                      validator: (password) =>
                          provider.validatePassword(password!),
                      onChanged: (value) {
                        provider.checkFormReadiness();
                        provider.validatePasswordOnChange(value);
                      }),
                  SizedBox(
                    height: AppSizes.pH3,
                  ),
                  CustomTextFormField(
                      onFocusChange: (hasFocus) =>
                          provider.validateConfirmPasswordOnFocusLose(hasFocus),
                      controller: provider.confirmPasswordController,
                      labelText: tr(AppConstants.confirmPassword),
                      obscureText: !provider.showPassword,
                      validator: (password) =>
                          provider.validateConfirmPassword(password!),
                      onChanged: (value) {
                        provider.checkFormReadiness();
                        provider.validateConfirmPasswordOnChange(value);
                      }),
                  SizedBox(
                    height: AppSizes.pH5,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomCheckBox(
                      onChanged: (bool value) =>
                          provider.changePasswordState(value),
                      child: CustomLink(
                        prefixText: tr(AppConstants.showPassword),
                        linkText: '',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.pH9,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomCheckBox(
                      onChanged: (bool value) =>
                          provider.setTermsAndConditionsState(value),
                      child: CustomLink(
                        prefixText: tr(AppConstants.signUpTermsAgreement),
                        linkText: tr(AppConstants.signUpTermsAgreementLink),
                        linkAction: () => provider.goToTermsAndPrivacyPolicy(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.pH8,
                  ),
                  CustomElevatedButton(
                      onPressed: () => provider.validateAndVerify(),
                      isEnabled: provider.enableVerifyButton,
                      isLoading: provider.isLoadingSignUp,
                      text: tr(AppConstants.verify)),
                  SizedBox(
                    height: AppSizes.pH8,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomLink(
                      prefixText: tr(AppConstants.haveAnAccount),
                      linkText: tr(AppConstants.signIn),
                      linkAction: () => provider.goToSignInScreen(),
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.pH8,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
