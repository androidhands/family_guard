import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoadingShimmer extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double width;
  final double height;

  const CustomLoadingShimmer(
      {Key? key, this.borderRadius, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Theme.of(context).cardColor.withOpacity(0),
      baseColor: Theme.of(context).primaryColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.br8)),
      ),
    );
  }
}
