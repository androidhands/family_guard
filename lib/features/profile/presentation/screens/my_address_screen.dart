import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/profile/presentation/controllers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/global/theme/theme_color/theme_color_light.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../widgets/custom_my_details_widget.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
        create: (context) => ProfileProvider(),
        builder: (context, child) {
          return Consumer<ProfileProvider>(builder: (context, provider, child) {
            return Scaffold(
              appBar: CustomAppbar(
                title: tr(AppConstants.addresses),
                withTransparent: false,
                withOutElevation: true,
                withMenu: true,
                actions: [
                  InkWell(
                    onTap: () {
                      provider.getUserAddress();
                    },
                    child: CustomSvgImage.icons(path: AppAssets.refresh),
                  )
                ],
                popOnPressed: () {
                  NavigationService.goBack();
                },
                popIconsColor: ThemeColorLight.pinkColor,
              ),
              body: provider.isLoadingUserAddree
                  ? Center(
                      child: CustomLoadingIndicators.defaultLoading(),
                    )
                  : Padding(
                      padding: EdgeInsets.all(AppSizes.pW5),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppSizes.mapAddressHight2,
                              width: AppSizes.widthFullScreen,
                              child: Stack(
                                children: [
                                  GoogleMap(
                                      onMapCreated: (controller) {
                                        provider.onMapCreated(controller);
                                      },
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              provider.addressEntity?.lat??0.0,
                                              provider.addressEntity?.lon??0.0))),
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

                              ///TODO Abdelhamid : use default value for parameter instead or repeating the check
                              ///Done
                              subTitle: provider.addressEntity!.country,
                              hasDevider: true,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.adminArea),
                              subTitle: provider.addressEntity!.adminArea,
                              hasDevider: true,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.subAdminArea),
                              subTitle: provider.addressEntity!.subAdminArea,
                              hasDevider: true,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.locality),
                              subTitle: provider.addressEntity!.locality,
                              hasDevider: true,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.subLocality),
                              subTitle: provider.addressEntity!.subLocality,
                              hasDevider: false,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.street),
                              subTitle: provider.addressEntity!.street,
                              hasDevider: false,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.postalCode),
                              subTitle: provider.addressEntity!.postalCode,
                              hasDevider: false,
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          });
        });
  }
}
