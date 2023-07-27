import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';


class CustomBorderIcon extends StatelessWidget {
  final String path;
  final Color? color;
  final Color? containerColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;

  const CustomBorderIcon({Key? key, required this.path, this.color, this.width, this.height, this.containerColor, this.borderRadius, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ??AppSizes.containerIconSize,
      height: height ?? AppSizes.containerIconSize,
      padding: EdgeInsets.all(AppSizes.pH2),
      margin: margin ?? EdgeInsets.all(AppSizes.pH2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: containerColor ?? Theme.of(context).cardColor,
          borderRadius:borderRadius?? BorderRadius.circular(AppSizes.br20)),
      child: CustomSvgImage(
          path: path, color: color ),
    );
  }
}
