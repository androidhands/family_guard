import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/buttons/custom_outlined_button.dart';
import 'package:family_guard/features/emergency/presentation/screens/calls_log_screen.dart';
import 'package:family_guard/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:family_guard/features/profile/presentation/components/profile_item_component.dart';
import 'package:family_guard/features/profile/presentation/screens/my_address_screen.dart';
import 'package:family_guard/features/profile/presentation/screens/my_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';

import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

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
            CustomText.primaryBodyLarge(tr(AppConstants.personal),
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: AppSizes.h7, color: ThemeColorLight.pinkColor)),
            CustomContainerWidget(
              children: [
                ProfileItemComponent(
                    path: AppAssets.person,
                    text: tr(AppConstants.myDetails),
                    onTap: () {
                      NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: () => const MyDetailsScreen());
                    }),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    onTap: () {
                      NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: () => const MyAddressScreen());
                    },
                    path: AppAssets.home,
                    text: tr(AppConstants.addresses)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    onTap: () {
                      NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: () => const NotificationsScreen());
                    },
                    path: AppAssets.notificationSvg,
                    text: tr(AppConstants.notifications)),
              ],
            ),

            /// Emergency
            CustomText.primaryBodyLarge(tr(AppConstants.emergencyCalls),
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: AppSizes.h7, color: ThemeColorLight.pinkColor)),
            CustomContainerWidget(
              children: [
                ProfileItemComponent(
                    path: AppAssets.emergencyCallSvg,
                    text: tr(AppConstants.callsLog),
                    onTap: () {
                      NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: () => const CallsLogScreen());
                    }),
              ],
            ),

            /// SETTINGS
            CustomText.primaryBodyLarge(tr(AppConstants.settings),
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: AppSizes.h7, color: ThemeColorLight.pinkColor)),
            CustomContainerWidget(
              children: [
                ProfileItemComponent(
                    path: AppAssets.changePassword,
                    text: tr(AppConstants.changePassword)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    path: AppAssets.shareAppSvg,
                    text: tr(AppConstants.shareApp)),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    onTap: () {
                      Get.defaultDialog(
                          title: tr(AppConstants.logOut),
                          content: Container(
                            height: AppSizes.pH100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.br40),
                            ),
                            child: Center(
                              child: CustomText('Are you shur to logout?',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: ThemeColorLight.pinkColor,
                                          fontSize: AppSizes.h6)),
                            ),
                          ),
                          confirm: CustomElevatedButton(
                            onPressed: () {
                              provider.logoutUser(context);
                            },
                            text: tr(AppConstants.logOut),
                            isLoading: provider.isLogOut,
                          ),
                          cancel: CustomOutlinedButton(
                            onPressed: () {
                              NavigationService.goBack();
                            },
                            text: tr(AppConstants.cancel),
                          ),
                          titleStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: ThemeColorLight.pinkColor,
                                  fontSize: AppSizes.h4));

                      // provider.logOut(context);
                    },
                    path: AppAssets.logoutSvg,
                    text: tr(
                      AppConstants.logOut,
                    )),
                const CustomProfileDivider(),
                ProfileItemComponent(
                    onTap: () {
                      Get.defaultDialog(
                          title: tr(AppConstants.deleteMyAccount),
                          content: Container(
                            height: AppSizes.pH100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.br40),
                            ),
                            child: Center(
                              child: CustomText(
                                  'Are you shur to delete your account permenently? You can not access your data again!',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: ThemeColorLight.pinkColor,
                                          fontSize: AppSizes.h6)),
                            ),
                          ),
                          confirm: CustomElevatedButton(
                            onPressed: () {
                              provider.deleteMyAccount(context);
                            },
                            text: tr(AppConstants.deleteMyAccount),
                            isLoading: provider.isLogOut,
                          ),
                          cancel: CustomOutlinedButton(
                            onPressed: () {
                              NavigationService.goBack();
                            },
                            text: tr(AppConstants.cancel),
                          ),
                          titleStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: ThemeColorLight.pinkColor,
                                  fontSize: AppSizes.h4));

                      // provider.logOut(context);
                    },
                    path: AppAssets.deleteSvg,
                    text: tr(
                      AppConstants.deleteMyAccount,
                    )),
              ],
            ),
          ])),
    );
  }
}
