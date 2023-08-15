import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_memory_image.dart';
import 'package:family_guard/core/widget/custom_network_image.dart';
import 'package:family_guard/core/widget/images/custom_avatar_image.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global/theme/theme_color/theme_color_light.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widget/custom_guard_shape.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/images/custom_svg_image.dart';

class CustomFamilyMemberWidget extends StatelessWidget {
  final UserEntity memberEntity;
  final UserEntity userEnt;
  final Function onPressed;

  const CustomFamilyMemberWidget(
      {Key? key,
      required this.memberEntity,
      required this.userEnt,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        height: 200.h,
        width: 220.w,
        margin: EdgeInsets.all(3.h),
        /*   decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.red)), */
        padding: const EdgeInsets.all(6),
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: CustomPaint(
              size: Size(170.w,
                  180.h), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: CustomGuardShape(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              memberEntity.imageUrl.isEmpty
                  ? CustomSvgImage(
                      path: AppAssets.profileMan,
                      height: 100.h,
                      width: 100.w,
                      color: ThemeColorLight.whiteColor,
                      radius: BorderRadius.circular(50),
                    )
                  : CustomNetworkImage.circle(
                      imageUrl: // userEntity.imageUrl,

                          memberEntity.imageUrl,
                      size: 70,
                      token: userEnt.apiToken!,
                    ),
              SizedBox(
                width: 140.w,
                child: CustomText(
                  memberEntity.userFullName,
                  textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: ThemeColorLight.whiteColor, fontSize: AppSizes.h6),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: CustomText(
                'My ${userEnt.id == memberEntity.memberEntity!.userId ? memberEntity.memberEntity!.memberRelation : memberEntity.memberEntity!.userRelation}',
                textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: ThemeColorLight.pinkColor,
                    ),
              ))
        ]),
      ),
    );
  }
}
