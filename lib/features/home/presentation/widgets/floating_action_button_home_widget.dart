import 'package:flutter/material.dart';

import '../../../../core/global/theme/theme_color/theme_color_light.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/images/custom_svg_image.dart';

class FloatingActionButtonHomeWidget extends StatelessWidget {
  const FloatingActionButtonHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.brMax),
            gradient: const LinearGradient(
              colors: [
                ThemeColorLight.pinkColor,
                ThemeColorLight.pinkWhiteColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        alignment: Alignment.center,
        child: const CustomSvgImage(
            path: AppAssets.sosSvig, color: ThemeColorLight.whiteIconColor),
      ),
      onPressed: () {},
    );
  }
}
