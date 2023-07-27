import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

import '../../global/theme/theme_color/theme_color_dark.dart';

///  done
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isEnabled = true,
      this.isLoading = false,
      this.iconAsset})
      : super(key: key);

  final bool isEnabled;
  final Function onPressed;
  final String text;
  final bool isLoading;
  final String? iconAsset;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isEnabled && !isLoading
            ? () {
                onPressed.call();
              }
            : null,
        style: isEnabled
            ? Theme.of(context).elevatedButtonTheme.style
            : Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).disabledColor,
                  ),
                  ),

        child: SizedBox(
          height: AppSizes.commonButtonsHight,
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isEnabled
                      ? [
                    ThemeColorLight.blueColor,
                    ThemeColorLight.blueWhiteColor,
                        ]
                      : [
                          Theme.of(context).disabledColor,
                          Theme.of(context).disabledColor
                        ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(AppSizes.br8)),
            child: Container(
                height: AppSizes.commonButtonsHight,
                /*  constraints:
                    const BoxConstraints(minHeight: 43.0, minWidth: 67.0), */
                alignment: Alignment.center,
                child: isLoading
                    ? CustomLoadingIndicators.defaultLoading(
                        color: ThemeColorDark.loadingColorElevatedButton,
                        size: AppSizes.loadingIndicatorMediumSize,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (iconAsset != null)
                            Row(
                              children: [
                                CustomSvgImage.icons(
                                    path: iconAsset!,
                                    color: Theme.of(context).iconTheme.color),
                                SizedBox(
                                  width: AppSizes.pW5,
                                )
                              ],
                            ),
                          CustomText.secondaryDisplaySmall(
                            text,
                            textStyle: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: isEnabled
                                        ?
                                    ThemeColorDark.elevatedButtonTextColor
                                        : Theme.of(context).dividerColor,
                                    fontSize: AppSizes.h5,
                                    height: 1.2),
                          ),
                        ],
                      )),
          ),
        ));
  }
}
