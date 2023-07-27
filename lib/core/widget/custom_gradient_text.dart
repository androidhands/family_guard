import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/app_fonts.dart';


class CustomGradientText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CustomGradientText({Key? key, required this.text, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      colors: const [
        ThemeColorLight.pinkColor,
        ThemeColorLight.pinkWhiteColor
      ],
      style: textStyle ??
          TextStyle(
            fontSize: AppSizes.h7,
            fontWeight: AppFonts.regular,
            fontFamily: AppFonts.fontFamilyEnglish,
          ),
    );
  }
}
