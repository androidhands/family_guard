import 'package:family_guard/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/features/authentication/presentation/controller/login/forget_password_provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../../../core/global/localization/app_localization.dart';

import '../../../../core/global/theme/theme_color/theme_color_light.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';
import '../../../../core/widget/custom_loading_indicator.dart';
import '../components/authentication_common_body.dart';
import '../components/authentication_header.dart';
import '../components/choose_verification_channel_components.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgetPasswordProvider>(
      create: (context) => ForgetPasswordProvider(),
      child: AuthenticationCommonBody(
        title: tr(AppConstants.forgetPassword),
        backOnPress: () => NavigationService.goBack(),
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
                    provider.isloadingCountryCode
                        ? Center(
                            child: CustomLoadingIndicators.defaultLoading(),
                          )
                        : IntlPhoneField(
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
                            controller: provider.phoneController,
                            onChanged: (phone) {
                              provider.setPhoneNumber(phone);
                              provider.checkFormReadiness();
                            },
                          ),
                    SizedBox(
                      height: AppSizes.pH3,
                    ),
                    ChooseVerificationChannelComponent(
                      onChanged: (channels) {
                        provider.setSelectedChannel(channels);
                      },
                      selectedChannel: provider.selectedChannel,
                    ),
                    SizedBox(
                      height: AppSizes.pH3,
                    ),
                    CustomElevatedButton(
                      onPressed: () => provider.verifyPhoneNumber(),
                      isLoading: provider.isLoadingPhoneCodes,
                      text: tr(AppConstants.submit),
                      isEnabled: provider.enableVerifyButton,
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
