import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/images/custom_png_image.dart';
import 'package:flutter/material.dart';

import 'package:family_guard/core/widget/custom_check_box.dart';
import 'package:family_guard/features/authentication/presentation/components/authentication_common_body.dart';
import 'package:family_guard/features/authentication/presentation/controller/login/login_provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';
import '../../../../core/widget/custom_links.dart';
import '../../../../core/widget/custom_text.dart';

import '../../../../core/widget/text_form_field/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return AuthenticationCommonBody(
            isScrolling: true,
            title: tr(AppConstants.signIn),
            isSignIn: true,
            body: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  /*   AuthenticationHeader(
                    title: tr(AppConstants.signIn),
                    subTitle: tr(AppConstants.orSocialSignIn),
                    isSignIn: true,
                    

                  ), */
                  SizedBox(
                    height: AppSizes.pH1,
                  ),
                  CustomPngImage(
                    path: AppAssets.appLogo,
                    width: AppSizes.logoImageWidth,
                    height: AppSizes.branchGenderWidgetWidth,
                    radius: BorderRadius.zero,
                  ),
                  SizedBox(
                    height: AppSizes.pH1,
                  ),
                  CustomText.primaryBodyLarge(
                    tr(AppConstants.signIn),
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
                    height: AppSizes.pH3,
                  ),
                  provider.isloadingCountryCode
                      ? Center(
                          child: CustomLoadingIndicators.defaultLoading(),
                        )
                      : IntlPhoneField(
                          dropdownTextStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontSize: AppSizes.h6,
                                  fontWeight: AppFonts.medium,
                                  color: ThemeColorLight.pinkColor),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontSize: AppSizes.h6,
                                  fontWeight: AppFonts.medium,
                                  color: ThemeColorLight.pinkColor),
                          decoration: InputDecoration(
                            labelText: tr(AppConstants.phoneNumber),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: provider.countryCode,
                          dropdownIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: ThemeColorLight.pinkColor,
                          ),
                          dropdownIconPosition: IconPosition.trailing,
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
                    controller: provider.passwordController,
                    onFocusChange: (hasFocus) {
                      provider.validatePasswordOnFocusLose(hasFocus);
                      provider.checkFormReadiness();
                    },
                    labelText: tr(AppConstants.password),
                    obscureText: !provider.showPassword,
                    validator: (password) =>
                        provider.validatePassword(password!),
                    onChanged: (value) {
                      provider.validatePasswordOnChange(value);
                      provider.checkFormReadiness();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: AppSizes.pW7,
                        top: AppSizes.pW6,
                        right: AppSizes.pW4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: CustomCheckBox(
                              onChanged: (val) {
                                provider.changePasswordState(val);
                              },
                              child: CustomText.secondaryDisplaySmall(
                                tr(AppConstants.showPassword),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontSize: AppSizes.h7,
                                    ),
                              ),
                            )),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CustomLink(
                            linkText: tr(AppConstants.forgetPassword),
                            prefixText: '',
                            linkAction: () =>
                                provider.gotoForgetPasswordScreen(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.pH2,
                  ),
                  CustomElevatedButton(
                    onPressed: () => provider.loginUser(),
                    isLoading: provider.isLoadingSignIn,
                    text: tr(AppConstants.signIn),
                    isEnabled: provider.enableVerifyButton,
                  ),
                  SizedBox(
                    height: AppSizes.pH7,
                  ),
                  CustomLink(
                    prefixText: tr(AppConstants.notAMemberYet),
                    linkText: tr(AppConstants.signUpNow),
                    linkAction: () => provider.gotoSignUpScreen(),
                  ),
                  SizedBox(
                    height: AppSizes.pH8,
                  ),
                  /*   AuthenticationHeader(
                    title: tr(AppConstants.signIn),
                    subTitle: tr(AppConstants.orSocialSignIn),
                    isSignIn: true,
                  ), */
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
