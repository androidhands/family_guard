import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:flutter/material.dart';

import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_boder_icon.dart';
import 'package:family_guard/core/widget/images/custom_cashed_network_image.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widget/custom_gradient_text.dart';
import '../../../../core/widget/custom_text.dart';
import '../controller/home_control_provider.dart';
import '../controller/home_provider.dart';
import 'package:badges/badges.dart' as badges;

class HeaderHomeComponent extends StatelessWidget {
  const HeaderHomeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeControlProvider, child) {
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
                      // provider.onProfileImagePress(context);
                      await Provider.of<MainProvider>(context, listen: false)
                          .logoutUser();
                    },
                    child: CustomSvgImage(
                      path: AppAssets.profileMan,
                      width: AppSizes.profileImageWidth,
                      height: AppSizes.profileImageHight,
                    )),

                ///Welcome,Location
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Welcome
                    CustomText(
                      '${tr(AppConstants.welcomeProfile)}\n ${homeControlProvider.userEntity?.firstName ?? ''}',
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
                        homeControlProvider.navigateToNotificationScreen();
                      },
                      child: badges.Badge(
                          badgeContent: CustomText(
                            '0',
                            textStyle: const TextStyle(color: Colors.white),
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
