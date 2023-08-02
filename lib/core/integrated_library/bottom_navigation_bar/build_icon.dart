
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/integrated_library/bottom_navigation_bar/tab_item.dart' as tap;


import '../../widget/images/custom_svg_image.dart';

class BuildIcon extends StatelessWidget {
  final tap.TabItem item;
  final double iconSize;
  final Color iconColor;
  final CountStyle? countStyle;

  const BuildIcon({
    Key? key,
    required this.item,
    required this.iconColor,
    this.iconSize = 22,
    this.countStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = CustomSvgImage(
      path: item.iconPath,
      color: iconColor,
    );
    if (item.count is Widget) {
      double sizeBadge = countStyle?.size ?? 18;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          CustomSvgImage(
            path: item.iconPath,
            color: iconColor,
            width: AppSizes.bottomBarIconWidth,
             height: AppSizes.bottomBarIconHigh,
          ),

          PositionedDirectional(
            start: iconSize - sizeBadge / 2,
            top: -sizeBadge / 2,
            child: item.count!,
          ),
        ],
      );
    }
    return icon;
  }
}
