import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';

import 'package:family_guard/core/widget/custom_loading_indicator.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/custom_links.dart';

class ResendCodeComponent extends StatelessWidget {
  final Future<void> Function() resendOnPress;
  final bool isLoading;

  const ResendCodeComponent(
      {Key? key, required this.resendOnPress, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.pH2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? CustomLoadingIndicators.loadingAnimation(
                  size: AppSizes.loadingIndicatorFOrSocialMediaSize)
              : CustomLink(
                  prefixStyle: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(
                          fontSize: AppSizes.h6, fontWeight: AppFonts.regular),
                  prefixText: tr(AppConstants.didntReceiveACode),
                  linkText: tr(AppConstants.resend),
                  linkAction: () async {
                    await resendOnPress();
                  }),
        ],
      ),
    );
  }
}
