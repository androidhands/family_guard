// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../global/theme/theme_color/theme_color_light.dart';
import '../../utils/app_sizes.dart';

class CustomSvgImage extends StatelessWidget {
  const CustomSvgImage({
    Key? key,
    required this.path,
    this.height,
    this.width,
    this.radius,
    this.fit = BoxFit.contain,
    this.color = ThemeColorLight.green,
  }) : super(key: key);

  CustomSvgImage.square({Key? key, required String path, Color? color})
      : this(
          key: key,
          path: path,
          height: AppSizes.imageWidthMedium,
          width: AppSizes.imageWidthMedium,
          color: color ?? ThemeColorLight.green,
          radius: BorderRadius.circular(AppSizes.br8),
        );

  CustomSvgImage.icons({Key? key, required String path, Color? color})
      : this(
            key: key,
            path: path,
            height: AppSizes.iconSize,
            width: AppSizes.iconSize,
            radius: BorderRadius.zero,
            fit: BoxFit.scaleDown,
            color: color ?? ThemeColorLight.green);

  final String path;
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? radius;
  final BoxFit fit;

  /// check radius
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: SvgPicture.asset(
        path,
        height: height,
        width: width,
        color: color,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
