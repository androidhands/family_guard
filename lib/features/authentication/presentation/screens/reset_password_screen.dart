import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';
import '../../../../core/widget/custom_check_box.dart';
import '../../../../core/widget/custom_links.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/text_form_field/custom_text_form_field.dart';
import '../../domain/entities/send_code_result_entity.dart';
import '../components/authentication_common_body.dart';
import '../components/authentication_header.dart';
import '../controller/reset_password_provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  final int tenantId;
  final SendCodeResultEntity sendCodeResultEntity;

  const ResetPasswordScreen(
      {Key? key, required this.sendCodeResultEntity, required this.tenantId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResetPasswordProvider>(
      create: (context) => sl(),
      child: Consumer<ResetPasswordProvider>(
        builder: (context, provider, child) {
          return WillPopScope(
            onWillPop: () async {
              provider.goBack();
              return false;
            },
            child: AuthenticationCommonBody(
                backOnPress: () {
                  provider.goBack();
                },
                title: tr(AppConstants.createNewPassword),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.pW1),
                  child: Form(
                    key: provider.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AuthenticationHeader(
                          title: tr(AppConstants.createNewPassword),
                          subTitle: tr(AppConstants
                              .wellAskForThisPasswordWheneverYouSignIn),
                          hasSocialMedia: false,
                          isSignIn: false,
                        ),
                        SizedBox(
                          height: AppSizes.pH8,
                        ),

                        /// password TextField
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

                        ///confirm password TextField
                        CustomTextFormField(
                            onFocusChange: (hasFocus) => provider
                                .validateConfirmPasswordOnFocusLose(hasFocus),
                            controller: provider.confirmPasswordController,
                            labelText: tr(AppConstants.confirmPassword),
                            obscureText: !provider.showPassword,
                            validator: (password) =>
                                provider.validateConfirmPassword(password!),
                            onChanged: (value) {
                              provider.checkFormReadiness();
                              provider.validateConfirmPasswordOnChange(value);
                            }),

                        ///hint password
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSizes.pW5),
                          child: CustomText(
                            tr(AppConstants.passwordCriteria),
                            textStyle: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle!
                                .copyWith(fontSize: AppSizes.h7),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.pH4,
                        ),

                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSizes.pW5),
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
                          height: AppSizes.pH8,
                        ),

                        ///Reset password button
                        CustomElevatedButton(
                            isEnabled: provider.enableVerifyButton,
                            onPressed: () => provider.submit(
                                sendCodeResultEntity: sendCodeResultEntity,
                                tenantId: tenantId,
                                context: context),
                            isLoading: provider.isLoadingResetPassword,
                            text: tr(AppConstants.submit)),
                        SizedBox(
                          height: AppSizes.pH3,
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
