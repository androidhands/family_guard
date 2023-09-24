import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/profile/presentation/widgets/custom_my_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMemberScreen extends StatelessWidget {
  final UserEntity userEntity;
  const ShowMemberScreen({Key? key, required this.userEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: tr(AppConstants.memberDetails),
          withTransparent: false,
          withOutElevation: true,
          withMenu: true,
          actions: const [SizedBox()],
          popOnPressed: () {
            NavigationService.goBack();
          },
          popIconsColor: ThemeColorLight.pinkColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.pW5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomMyDetailsWidget(
                  title: tr(AppConstants.firstNameProfile),
                  subTitle: userEntity.firstName,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.lastNameProfile),
                  subTitle: userEntity.secondName,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.familyNameProfile),
                  subTitle: userEntity.familyName,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.mobileNumber),
                  subTitle: userEntity.mobile,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.emailAddress),
                  subTitle: userEntity.email,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.gender),
                  subTitle: userEntity.gender == "0"
                      ? tr(AppConstants.male)
                      : tr(AppConstants.female),
                  hasDevider: true,
                ),
                SizedBox(
                  height: AppSizes.mapAddressHight2,
                  width: AppSizes.widthFullScreen,
                  child: Stack(
                    children: [
                      GoogleMap(
                          onMapCreated: (controller) {
                            //  provider.onMapCreated(controller);
                          },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(userEntity.address?.lat ?? 0.0,
                                  userEntity.address?.lon ?? 0.0))),
                      Center(
                          child: CustomSvgImage(
                        path: AppAssets.pinLocation,
                        width: AppSizes.locationIndicatorWidth,
                        height: AppSizes.locationIndicatorHight,
                      )),
                    ],
                  ),
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.country),
                  subTitle: userEntity.address!.country,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.adminArea),
                  subTitle: userEntity.address!.adminArea,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.subAdminArea),
                  subTitle: userEntity.address!.subAdminArea,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.locality),
                  subTitle: userEntity.address!.locality,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.subLocality),
                  subTitle: userEntity.address!.subLocality,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.street),
                  subTitle: userEntity.address!.street,
                  hasDevider: true,
                ),
                CustomMyDetailsWidget(
                  title: tr(AppConstants.postalCode),
                  subTitle: userEntity.address!.postalCode,
                  hasDevider: true,
                ),
              ],
            ),
          ),
        ));
  }
}
