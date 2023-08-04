import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';
import '../../../../core/widget/floating_action_buttons/extended_floating_action_button.dart';
import '../../../../core/widget/images/custom_svg_image.dart';
import '../components/header_home_component.dart';
import '../controller/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        return Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: Stack(
                fit: StackFit.loose,
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: provider.initialCameraPosition,
                    zoomControlsEnabled: false,
                    onCameraIdle: () => provider.changeLocation(context),
                    onMapCreated: (googleMapController) =>
                        provider.onMapCreated(googleMapController),
                    myLocationButtonEnabled: false,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(AppSizes.pW6),
                          child: provider.isLoadingLocation?CustomLoadingIndicators.defaultLoading():
                          CustomFloatingActionButton(
                            iconSVGPath: AppAssets.gpsSvg,
                            onTap: () => provider.goToMyLocation(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(AppSizes.pW6),
                          child: CustomFloatingActionButton(
                            iconSVGPath: AppAssets.familySvg,
                            onTap: () => provider.goToMyLocation(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: provider.middleY,
                      right: provider.middleX,
                      child: CustomSvgImage(
                        path: AppAssets.pinLocation,
                        width: AppSizes.locationIndicatorWidth,
                        height: AppSizes.locationIndicatorHight,
                      )),
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: HeaderHomeComponent(),
                  ),
                ],
              ),

              /* Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const HeaderHomeComponent(),
                 /*  CustomElevatedButton(
                    text: tr(AppConstants.logOut),
                    onPressed: () async {
                      await Provider.of<MainProvider>(context, listen: false)
                          .logoutUser();
                    },
                  ) */
                ],
              ), */
            );
          },
        );
      },
    );
  }
}
