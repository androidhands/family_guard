import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:family_guard/features/authentication/presentation/controller/login/forget_password_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/global/localization/app_localization.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/text_form_field/custom_text_form_field.dart';
import '../components/authentication_common_body.dart';
import '../components/authentication_header.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgetPasswordProvider>(
      create: (context) => ForgetPasswordProvider(sl()),
      child: AuthenticationCommonBody(
        title: tr(AppConstants.forgetPassword),
        body: Consumer<ForgetPasswordProvider>(
          builder: (context, provider, child) {
            return Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    AuthenticationHeader(
                      title: tr(AppConstants.forgetPassword),
                      subTitle: tr(AppConstants.insertEmailOrPasswordForgetPSW),
                      isSignIn: false,
                      hasSocialMedia: false,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: AppSizes.pW5, vertical: AppSizes.pH5),
                      child: const Divider(
                        thickness: 1,

                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        Expanded(
                          child: CustomTextFormField(
                            key: provider.countryPickerWidgetKey,
                            controller: provider.emailOrPhoneController,
                            onFocusChange: (hasFocus) =>
                                provider.validateEmailOrMobilePhoneOnFocusLose(
                                    hasFocus),
                            labelText: tr(AppConstants.emailAddress),
                           
                            inputFormatters: [
                              provider.preventLettersInPhoneField
                                  ? FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                  : FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z0-9@.]")),
                            ],
                            validator: (value) =>
                                provider.validateEmailOrMobilePhone(value!),
                            onChanged: (value) {
                              provider.checkPhoneField(value);
                              provider
                                  .validateEmailOrMobilePhoneOnChange(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.pH7,
                    ),

                   
                  ],
                ));
          },
        ),
      ),
    );
  }
}
