import 'package:flutter/material.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import '../../global/theme/theme_color/theme_color_light.dart';
import '../../utils/app_sizes.dart';
import '../custom_text.dart';
import '../images/custom_svg_image.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.textButton,
      required this.onPressed,
      this.isLoading = false,
      this.isEnable = true,
      this.style,
      this.iconAsset})
      : super(key: key);

  final void Function() onPressed;
  final String textButton;
  final bool isLoading;
  final bool isEnable;
  final TextStyle? style;
  final String? iconAsset;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isEnable && !isLoading ? onPressed : null,

        child: SizedBox(
          height: AppSizes.commonButtonsHight,
          child: isLoading
              ? CustomLoadingIndicators.defaultLoading(
                  size: 10,
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
                    CustomText.pinkBold(textButton,
                        textStyle: isEnable
                            ? style ??
                                Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: AppSizes.h6)
                            : Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: ThemeColorLight.disableColor,
                                    fontSize: AppSizes.h6),
                        textAlign: TextAlign.center),
                  ],
                ),
        ));
  }
}
