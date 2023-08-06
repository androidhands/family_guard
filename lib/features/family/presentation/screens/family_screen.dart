import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/custom_guard_shape.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Container(
        height: 200.h,
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.red)),
        padding: const EdgeInsets.all(6),
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: CustomPaint(
              size: Size(150.w,
                  200.h), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: CustomGuardShape(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomSvgImage(
                path: AppAssets.profileMan,
                height: 100.h,
                width: 100.w,
                color: ThemeColorLight.whiteColor,
                radius: BorderRadius.circular(50),
              ),
              SizedBox(
                width: 140.w,
                child: CustomText(
                  'Name Name Name',
                  textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: ThemeColorLight.whiteColor,
                      ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          )
        ]),
      ),
    ));
  }
}
