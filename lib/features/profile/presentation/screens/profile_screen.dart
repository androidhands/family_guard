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
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/images/custom_avatar_image.dart';
import '../../../../core/widget/images/custom_svg_image.dart';
import '../../../home/presentation/controller/home_control_provider.dart';
import '../components/profile_details_component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: tr(AppConstants.profile),
          withTransparent: false,
          withOutElevation: true,
          withMenu: true,
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
                        /// Profile Image
                        CustomSvgImage(
                          path: AppAssets.profileMan,
                          width: AppSizes.profileImageWidth,
                          height: AppSizes.profileImageHight,
                        ),

                        /* CustomAvatarImage(
                          "", //refineImage(userData.profileImageUrl),
                          //
                          width: AppSizes.profileImageWidth,
                          height: AppSizes.profileImageWidth,
                        ), */
                        SizedBox(height: AppSizes.pH2),

                        /// User Name
                        CustomText.primaryBodyLarge('Full Name',
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
