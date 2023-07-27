import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';

import '../custom_text.dart';
import '../images/custom_svg_image.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isEnabled = true,
      this.isLoading = false,
      this.iconAsset})
      : super(key: key);
  final bool isEnabled;
  final void Function() onPressed;
  final String text;
  final bool isLoading;
  final String? iconAsset;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: /* isEnabled
            ? Theme.of(context).outlinedButtonTheme.style
            :  */
            Theme.of(context).outlinedButtonTheme.style!.copyWith(
                  side: MaterialStateProperty.resolveWith<BorderSide>(
                      (states) =>
                          BorderSide(color: Theme.of(context).dividerColor)),
                ),

       
        /// UNACCEPTABLE

        child: Container(
          constraints: BoxConstraints(maxHeight: AppSizes.commonButtonsHight),
          child: isLoading
              ? CustomLoadingIndicators.defaultLoading(
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
                          ),
                          SizedBox(
                            width: AppSizes.pW5,
                          )
                        ],
                      ),
                    CustomText.primaryBodyLarge(
                      text,
                      textStyle: isEnabled
                          ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: AppSizes.h6,
                              fontWeight: AppFonts.regular)
                          : Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).disabledColor,
                              ),
                    ),
                  ],
                ),
        ));
  }
}
