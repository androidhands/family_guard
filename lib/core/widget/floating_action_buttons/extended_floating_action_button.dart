import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

import '../images/custom_svg_image.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String iconSVGPath;
  final void Function()? onTap;

  const CustomFloatingActionButton({Key? key, required this.iconSVGPath, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizes.logoSize,
        height: AppSizes.logoSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.brMax),
            gradient:  const LinearGradient(
              colors: [
                ThemeColorLight.pinkColor,
                ThemeColorLight.pinkWhiteColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        alignment: Alignment.center,
        child: CustomSvgImage(
            path: iconSVGPath,
            color: ThemeColorLight.whiteColor),
      ),
    );
  }
}
