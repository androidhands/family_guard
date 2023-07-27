import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';

class CustomPngImage extends StatelessWidget {
  const CustomPngImage(
      {Key? key,
      required this.path,
      this.height,
      this.width,
      this.radius,
      this.color})
      : super(key: key);

  CustomPngImage.square({Key? key, required String path})
      : this(
            key: key,
            path: path,
            height: AppSizes.imageWidthMedium,
            width: AppSizes.imageWidthMedium,
            radius: BorderRadius.circular(AppSizes.br8),
            );

  final String path;
  final double? height;
  final double? width;

  final BorderRadius? radius;
  final Color? color;

  /// check radius
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Image.asset(
        path,
        height: height,
        width: width,
        fit: BoxFit.fill,
        key: key,
      ),
    );
  }
}
