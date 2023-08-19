import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_sizes.dart';
import '../widget/custom_text.dart';
import '../widget/images/custom_svg_image.dart';

class CustomDropDownButton extends StatelessWidget {
  final void Function()? onClick;
  final bool isEnabled;
  final double? height;
  final String title;

  const CustomDropDownButton(
      {Key? key,
      this.onClick,
      this.isEnabled = true,
      this.height,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (onClick != null) onClick!();
      },
      child: Container(
        height: height,
        width: double.infinity,
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pW5,
        ),
        decoration: BoxDecoration(
          // color: Theme.of(context).cardColor,
          border: Border.all(
            color:
                Theme.of(context).inputDecorationTheme.border!.borderSide.color,
            width: AppSizes.bs1_0,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title,
              textStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            ),
            Transform.rotate(
              angle: (270 * math.pi) / 180,
              child: CustomSvgImage(
                path: AppAssets.backSvg,
                color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
                width: AppSizes.pW5,
                height: AppSizes.pH5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
