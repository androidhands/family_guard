import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/buttons/custom_text_button.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/authentication/presentation/controller/select_country/enable_user_location_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/component/localization_changer_widget.dart';
import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/images/custom_png_image.dart';

class EnableLocationModalSheet extends StatelessWidget {
  const EnableLocationModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EnableUserLocationProvider(),
        builder: (context, child) {
          return Consumer<EnableUserLocationProvider>(
              builder: (context, provider, child) {
            return Stack(
              children: [
                CustomPngImage(
                    path: AppAssets.selectCountryPng,
                    height: AppSizes.heightFullScreen,
                    width: AppSizes.widthFullScreen,
                    radius: BorderRadius.circular(0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSizes.customCardH1,
                    ),
                    Center(
                      child: CustomPngImage.square(
                        path: AppAssets.locationCircle,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.countryFlagHeight,
                    ),
                    CustomText.primaryBodyLarge(
                      tr(AppConstants.enableYourLocationText),
                      textStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                    SizedBox(
                      height: AppSizes.pH1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppSizes.pW5),
                      child: CustomText.thirdTitleSmall(
                        tr(AppConstants.appRequiresLocationText),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppSizes.pW8, right: AppSizes.pW8),
                      child: CustomElevatedButton(
                        onPressed: () {
                          provider.checkPermission();
                        },
                        text: tr(AppConstants.allowLocationBottonText),
                        isEnabled: true,
                        isLoading: provider.isLoadingLocationService,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextButton(
                          textButton: tr(
                            AppConstants.notAllowLocationBottonText,
                          ),
                          onPressed: () {
                           
                          },
                          style: Theme.of(context).textTheme.labelMedium,
                        )),
                    const Expanded(child: SizedBox()),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: LocalizationChangeWidget(),
                    ),
                  ],
                )
              ],
            );
          });
        });
  }
}
