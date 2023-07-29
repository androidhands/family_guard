import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/authentication/presentation/components/resend_code_component.dart';
import 'package:family_guard/features/authentication/presentation/components/timer_verification_component.dart';
import 'package:family_guard/features/authentication/presentation/controller/forget_password_verification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';
import '../../../../core/widget/custom_gradient_text.dart';
import '../../../../core/widget/custom_pin_code_text.dart';

class VerificationForgetPasswordContentCardComponent extends StatelessWidget {
  const VerificationForgetPasswordContentCardComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPasswordVerificationProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.pW1),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ///headlines
                SizedBox(
                  height: AppSizes.pH8,
                ),
                CustomText.thirdTitleSmall(
                  tr(tr(AppConstants.verification)),
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: AppFonts.medium, fontSize: AppSizes.h4),
                ),
                SizedBox(
                  height: AppSizes.pH1,
                ),
                CustomText.secondaryDisplaySmall(
                  tr(AppConstants.weHaveSentYouACodeTo),
                  textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: AppFonts.regular, fontSize: AppSizes.h6),
                ),
                SizedBox(
                  height: AppSizes.pH1,
                ),
                CustomGradientText(
                  text: provider.phone,
                  textStyle: TextStyle(
                      fontSize: AppSizes.h7, fontWeight: AppFonts.medium),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.pH7),
                  child: Divider(
                    height: 0,
                    thickness: 0.25,
                    color: Theme.of(context).dividerColor,
                  ),
                ),

                CustomText.thirdTitleSmall(
                  tr(tr(AppConstants.enterOTPCode)),
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: AppFonts.medium, fontSize: AppSizes.h4),
                ),
                SizedBox(
                  height: AppSizes.pH1,
                ),
                CustomText.secondaryDisplaySmall(
                  tr(AppConstants
                      .enterVerificationCodeThatWeSentYouThroughYourEmailOrMobileNumber),
                  textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: AppFonts.regular, fontSize: AppSizes.h6),
                ),
                SizedBox(
                  height: AppSizes.pH7,
                ),

                ///pin code
                CustomPinCodeTextField(
                  controller: provider.pinCodeController,
                  onDone: (value) async {
                    await provider.onComplete();
                  },
                  onChanged: (value) {
                    provider.onChangedPinCode();
                  },
                ),
                SizedBox(
                  height: AppSizes.pH1,
                ),

                ///submit button
                CustomElevatedButton(
                    isEnabled: provider.isEnableSubmitButton(),
                    onPressed: () {
                      provider.onSubmit(context);
                    },
                    text: tr(AppConstants.verify)),
                SizedBox(
                  height: AppSizes.pH6,
                ),

                ///Timer,Resend Code
                provider.timerIsRunning
                    ? TimerVerificationComponent(
                        timerSecond: provider.getTimerText,
                      )
                    : ResendCodeComponent(
                        isLoading: provider.isLoadingResendButton,
                        resendOnPress: () async {
                          await provider.resendOnPress(context);
                        }),

                SizedBox(
                  height: AppSizes.pH6,
                ),
              ]),
        );
      },
    );
  }
}
