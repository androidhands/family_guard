import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/widget/custom_network_image.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../global/theme/theme_color/theme_color_light.dart';
import '../utils/app_sizes.dart';

class ImageProfileWidget extends StatelessWidget {
  final String url;
  final double? size;
  final bool isExistBorder;
  final bool isExistEdit;

  const ImageProfileWidget(
      {Key? key,
      required this.url,
      this.size,
      this.isExistBorder = false,
      this.isExistEdit = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.brMax),
              border: isExistBorder
                  ? GradientBoxBorder(
                      gradient: const LinearGradient(
                        colors: [
                          ThemeColorLight.blueColor,
                          ThemeColorLight.blueWhiteColor,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      width: AppSizes.mediumBorderGradientWidth,
                    )
                  : null),
          child: CustomNetworkImage(
            imageUrl: url,
            width: size ?? AppSizes.imageProfileLargeSize,
            height: size ?? AppSizes.imageProfileLargeSize,
            fit: BoxFit.fill,
            radius: BorderRadius.circular(AppSizes.brMax),
          ),
        ),
        if (isExistEdit)
          Positioned(
            bottom: AppSizes.cameraEditPosition,
            // alignment: Alignment.bottomCenter,
            child: CustomSvgImage(
              path: AppAssets.cameraEditSvg,
              width: AppSizes.mediumIconSize,
              height: AppSizes.mediumIconSize,
            ),
          )
      ],
    );
  }
}
