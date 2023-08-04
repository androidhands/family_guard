import 'package:family_guard/features/profile/presentation/components/profile_item_component.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/app_theme.dart';
import 'package:family_guard/core/global/theme/controller/theme_provider.dart';

import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_switch/custom_switch_button.dart';
import 'package:family_guard/core/widget/custom_switch/custom_switch_outlined.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

import 'package:provider/provider.dart';

import '../../../../core/services/navigation_service.dart';
import '../controllers/profile_provider.dart';
import '../widgets/custom_container_widget.dart';
import '../widgets/custom_profile_divider.dart';

class ProfileDetailsComponent extends StatelessWidget {
  const ProfileDetailsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) => Align(
          alignment: AlignmentDirectional.topStart,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ///  PROFILE SETTINGS
            CustomText.primaryBodyLarge(tr(AppConstants.profileSetting),
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: AppSizes.h7,
                    )),
            CustomContainerWidget(
              children: [
                ProfileItemComponent(
                    path: AppAssets.person,
                    text: tr(AppConstants.myDetails),
                    onTap: () {
                     /*  NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: () => const MyDetailsScreen()); */
                    }),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.homeSvg,
                    text: tr(AppConstants.addresses)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.home, text: tr(AppConstants.wallet)),
              ],
            ),

            /// APPLICATION
            CustomText.primaryBodyLarge(tr(AppConstants.application),
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: AppSizes.h7,
                    )),
            CustomContainerWidget(
              children: [
                ProfileItemComponent(
                    path: AppAssets.calendar, text: tr(AppConstants.myReviews)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.notification,
                    text: tr(AppConstants.notifications)),
                const CustomProfileDivider(),
                ProfileToggleItem(
                    onChange: () {
                      provider.changeTheme(context);
                    },
                    value: Provider.of<ThemeProvider>(context).appTheme ==
                        AppTheme.values[0])
              ],
            ),

            /// SETTINGS
            CustomText.primaryBodyLarge(tr(AppConstants.settings),
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: AppSizes.h7,
                    )),
            CustomContainerWidget(
              children: [
                ProfileItemComponent(
                    path: AppAssets.changePassword,
                    text: tr(AppConstants.changePassword)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.language, text: tr(AppConstants.language),onTap: (){
                  provider.changeLanguage();
                }),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.locationSvg,
                    text: tr(AppConstants.changeLocation,
                    ),onTap: (){

                }),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.country,
                    text: tr(AppConstants.changeCountry)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.callSvg, text: tr(AppConstants.contactUs)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.share, text: tr(AppConstants.shareApp)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    onTap: () {
                      provider.logOut(context);
                    },
                    path: AppAssets.logoutSvg,
                    text: tr(
                      AppConstants.logOut,
                    )),
              ],
            ),
          ])),
    );
  }
}
