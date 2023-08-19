import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/widget/custom_network_image.dart';
import 'package:family_guard/core/widget/images/custom_cashed_network_image.dart';
import 'package:flutter/material.dart';

import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_boder_icon.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widget/custom_text.dart';
import '../controller/home_provider.dart';
import 'package:badges/badges.dart' as badges;

class HeaderHomeComponent extends StatelessWidget {
  const HeaderHomeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizes.br30),
                  bottomRight: Radius.circular(AppSizes.br30))),
          child: Padding(
            padding: EdgeInsets.only(
                left: AppSizes.pH1, right: AppSizes.pH4, top: AppSizes.pH1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///image profile
                GestureDetector(
                  onTap: () async {
                    provider.navigateToProfileScreen();
                  },
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: provider.userEntity?.imageUrl == null
                          ? CustomSvgImage(
                              path: AppAssets.profileMan,
                              width: AppSizes.profileImageWidth,
                              height: AppSizes.profileImageHight,
                            )
                          : CustomCashedNetworkImage.circle(
                              imageUrl: provider.userEntity!.imageUrl,
                              size: 50,
                              token: provider.userEntity!.apiToken!)),
                ),

                ///Welcome,Location
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Welcome
                    CustomText(
                      '${tr(AppConstants.welcomeProfile)}\n ${provider.userEntity?.firstName ?? ''}',
                      textStyle: TextStyle(
                          fontSize: AppSizes.h5,
                          fontWeight: AppFonts.regular,
                          fontFamily: AppFonts.fontFamilyEnglish,
                          color: ThemeColorLight.pinkColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                ///Notification Icon Button
                Padding(
                  padding: EdgeInsets.only(right: AppSizes.pW1),
                  child: GestureDetector(
                      onTap: () {
                        provider.navigateToNotificationScreen();
                      },
                      child: badges.Badge(
                          badgeContent: const CustomText(
                            '0',
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          position: badges.BadgePosition.topEnd(),
                          child: CustomBorderIcon(
                            path: AppAssets.notificationSvg,
                            color: Theme.of(context).primaryColor,
                            margin:
                                EdgeInsetsDirectional.only(top: AppSizes.pH1),
                          ))),
                ),

                /* CustomCashedNetworkImage.circle(
                          imageUrl: refineImage(
                              homeControlProvider.userData.thumbImageUrl),
                          size: AppSizes.imageProfileHeightInHomeScreen,
                        ),
                      )
                    : SizedBox(
                        width: AppSizes.imageProfileHeightInHomeScreen,
                      ) */
              ],
            ),
          ),
        );
      },
    );
  }
}
