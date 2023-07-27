import 'package:flutter/material.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/custom_gradient_text.dart';
import '../../../../core/widget/custom_text.dart';

class TimerVerificationComponent extends StatelessWidget {
  final String timerSecond;
  const TimerVerificationComponent({Key? key, required this.timerSecond})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ///
        CustomText.secondaryDisplaySmall(
          tr(AppConstants.didntReceiveTheVerificationCode),
          textStyle: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontSize: AppSizes.h6, fontWeight: AppFonts.regular),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText.secondaryDisplaySmall(
              tr(AppConstants.requestNewCodeIn),
              textStyle: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: AppSizes.h6, fontWeight: AppFonts.regular),
            ),
            CustomGradientText(
              text: ' $timerSecond ${tr(AppConstants.seconds)} ',
              textStyle:
                  TextStyle(fontSize: AppSizes.h6, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
