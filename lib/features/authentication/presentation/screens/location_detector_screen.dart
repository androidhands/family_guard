import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/features/authentication/domain/entities/sign_up_params.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/floating_action_buttons/extended_floating_action_button.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/core/widget/text_form_field/custom_text_form_field.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../components/authentication_common_body.dart';
import '../controller/location_detector_provider.dart';

class LocationDetectorScreen extends StatelessWidget {
  SignUpParams signUpParams;
  LocationDetectorScreen({Key? key, required this.signUpParams})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationDetectorProvider(signUpParams: signUpParams),
      child: Consumer<LocationDetectorProvider>(
        builder: (context, provider, child) => AuthenticationCommonBody(
          isScrolling: true,
          backOnPress: () => NavigationService.goBack(),
          title: tr(AppConstants.signUp),
          body: Column(
            children: [
              CustomText.primaryBodyLarge(
                tr(AppConstants.signUp),
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSizes.h4,
                    ),
              ),
              SizedBox(
                height: AppSizes.pH1,
              ),
              CustomText.secondaryDisplaySmall(
                tr(AppConstants.saveYourAddreess),
                textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: AppSizes.h7,
                    ),
              ),
              SizedBox(
                height: AppSizes.pH3,
              ),
              SizedBox(
                height: AppSizes.mapAddressHigh, // 350.h,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: provider.initialCameraPosition,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: true,
                      scrollGesturesEnabled: true,
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>{}
                            ..add(Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()))
                            ..add(Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer())),
                      onCameraIdle: () => provider.changeLocation(context),
                      onMapCreated: (googleMapController) =>
                          provider.onMapCreated(googleMapController),
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
                            child: CustomFloatingActionButton(
                              iconSVGPath: AppAssets.gpsSvg,
                              onTap: () => provider.goToMyLocation(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: CustomSvgImage(
                          path: AppAssets.pinLocation,
                          width: AppSizes.locationIndicatorWidth,
                          height: AppSizes.locationIndicatorHight,
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.pH4, horizontal: AppSizes.pW6),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: provider.countryTextController,
                        readonly: true,
                        labelText: tr(AppConstants.country),
                      ),
                      const SizedBox(
                        height: AppSizes.e3,
                      ),
                      CustomTextFormField(
                        controller: provider.adminAreaTextController,
                        readonly: true,
                        labelText: tr(AppConstants.adminArea),
                      ),
                      const SizedBox(
                        height: AppSizes.e3,
                      ),
                      CustomTextFormField(
                        controller: provider.subAdminAreaTextController,
                        labelText: tr(AppConstants.state),
                      ),
                      const SizedBox(
                        height: AppSizes.e3,
                      ),
                      CustomTextFormField(
                        controller: provider.localityTextController,
                        labelText: tr(AppConstants.district),
                      ),
                      const SizedBox(
                        height: AppSizes.e3,
                      ),
                      CustomTextFormField(
                        controller: provider.subLocalityextController,
                        labelText: tr(AppConstants.city),
                      ),
                      const SizedBox(
                        height: AppSizes.e3,
                      ),
                      CustomTextFormField(
                        controller: provider.streetTextController,
                        labelText: tr(AppConstants.street),
                      ),
                      const SizedBox(
                        height: AppSizes.e3,
                      ),
                      CustomTextFormField(
                        controller: provider.postalCodeTextController,
                        labelText: tr(AppConstants.postalCode),
                      ),
                      const SizedBox(
                        height: AppSizes.e3,
                      ),
                      provider.isLoadingLocation
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLoadingIndicators.defaultLoading(
                                    size: AppSizes
                                        .loadingIndicatorFOrSocialMediaSize),
                                SizedBox(
                                  width: AppSizes.pW6,
                                ),
                                CustomText.primaryBodyLarge(
                                  tr(AppConstants.detectingLocation),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: AppSizes.h5),
                                )
                              ],
                            )
                          : CustomElevatedButton(
                              text: tr(AppConstants.submit),
                              isEnabled: provider.isCountryInRegion,
                              isLoading: provider.isLoadingLocation ||
                                  provider.isSavingNewCountry,
                              onPressed: () =>
                                  provider.saveNewLocation(context),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
