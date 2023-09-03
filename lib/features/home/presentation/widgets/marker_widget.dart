import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/widget/custom_guard_shape.dart';
import 'package:family_guard/core/widget/custom_network_image.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarkerWidget extends StatelessWidget {
  final String imageUrl;
  final String accessToken;
  const MarkerWidget(
      {Key? key, required this.imageUrl, required this.accessToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 100.w,
      margin: EdgeInsets.all(3.h),
      /*   decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.red)), */
      padding: const EdgeInsets.all(6),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            size: Size(100.w,
                100.h), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: CustomGuardShape(),
          ),
        ),
       /*  Align(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            imageUrl.isEmpty
                ? CustomSvgImage(
                    path: AppAssets.profileMan,
                    height: 70.h,
                    width: 70.w,
                    color: ThemeColorLight.whiteColor,
                    radius: BorderRadius.circular(50),
                  )
                : CustomNetworkImage.circle(
                    imageUrl: // userEntity.imageUrl,

                        imageUrl,
                    size: 70,
                    token: accessToken,
                  ),
          ]),
        ), */
      ]),
    );
  }
}
