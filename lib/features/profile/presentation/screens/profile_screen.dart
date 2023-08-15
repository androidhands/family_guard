import 'package:family_guard/core/global/theme/theme_color/theme_color_dark.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/features/profile/presentation/controllers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../../../../core/widget/custom_network_image.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/images/custom_avatar_image.dart';
import '../../../../core/widget/images/custom_svg_image.dart';
import '../../../home/presentation/controller/home_control_provider.dart';
import '../components/profile_details_component.dart';
import 'package:badges/badges.dart' as badges;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: tr(AppConstants.profile),
          withTransparent: false,
          withOutElevation: true,
          withMenu: false,
          actions: const [SizedBox()],
          popOnPressed: () {
            NavigationService.goBack();
          },
          popIconsColor: ThemeColorLight.pinkColor,
        ),
        body: ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
          builder: (context, child) {
            return Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.pW5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: AppSizes.pH8),

                        InkWell(
                            onTap: () {
                              provider.openImages();
                            },
                            child: SizedBox(
                              width: AppSizes.profileImageWidth,
                              height: AppSizes.profileImageHight,
                              child: Stack(
                                children: [
                                  provider.user.imageUrl.isEmpty
                                      ? CustomSvgImage(
                                          path: AppAssets.profileMan,
                                          width: AppSizes.profileImageWidth,
                                          height: AppSizes.profileImageHight,
                                        )
                                      : CustomNetworkImage.circle(
                                          imageUrl: provider.user.imageUrl,
                                          size: 50,
                                          token: provider.user.apiToken!),
                                  Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: CustomSvgImage.square(
                                      path: AppAssets.gallerySvg,
                                      color: ThemeColorLight.pinkColor,
                                    ),
                                  )
                                ],
                              ),
                            )),

                        /// Profile Image

                        /* CustomAvatarImage(
                          "", //refineImage(userData.profileImageUrl),
                          //
                          width: AppSizes.profileImageWidth,
                          height: AppSizes.profileImageWidth,
                        ), */
                        SizedBox(height: AppSizes.pH2),

                        /// User Name
                        CustomText.primaryBodyLarge(provider.user.userName,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: AppSizes.h6,
                                    fontWeight: AppFonts.medium)),

                        /// User Location

                        SizedBox(height: AppSizes.pH5),

                        SizedBox(height: AppSizes.pH8),
                        const ProfileDetailsComponent(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
