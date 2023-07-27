import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';

import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

class LocalizationChangeWidget extends StatelessWidget {
  final void Function()? onLanguageChange;

  const LocalizationChangeWidget({Key? key, this.onLanguageChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sl<BaseAppLocalizations>().changeLocale();
        if (onLanguageChange != null) onLanguageChange!();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: AppSizes.pH8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomSvgImage(
              path: AppAssets.gloablSvg,
              color: ThemeColorLight.green,
            ),
            SizedBox(
              width: AppSizes.pH1,
            ),
            CustomText.primaryBodyLarge(
              tr(sl<BaseAppLocalizations>().isEnglish()
                  ? AppConstants.arabicLanhaugeText
                  : AppConstants.englishLanhaugeText),
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: AppSizes.h7, color: ThemeColorLight.green),
            ),
          ],
        ),
      ),
    );
  }
}
