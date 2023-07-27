import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/component/localization_changer_widget.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_outlined_button.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constants.dart';
import '../services/connectivity_services.dart';
import '../services/dependency_injection_service.dart';

class NoNetWorkScreen extends StatelessWidget {
  const NoNetWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        log("Can Go Back : ${sl<ConnectivityService>().canGoBack}");
        return Future.value(sl<ConnectivityService>().canGoBack);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pW8, vertical: AppSizes.pH8),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Logo
                  CustomSvgImage(
                    path: AppAssets.logoSvg,
                  ),

                  ///Middle Home Component
                  NetworkBodyComponent(),

                  /// Localization widget
                  LocalizationChangeWidget(),
                ]),
          ),
        ),
      ),
    );
  }
}

class NetworkBodyComponent extends StatelessWidget {
  const NetworkBodyComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// receive Info icon
        // const CustomSvgImage(path: AppAssets.noInternetLogo),
        SizedBox(
          height: AppSizes.pH3,
        ),

        ///Subtitles 1
        CustomText.primaryBodyLarge(
          tr(AppConstants.oopsSomethingWentWrong),
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: AppFonts.medium, fontSize: AppSizes.h6),
        ),
        SizedBox(
          height: AppSizes.pH1,
        ),

        ///Subtitles 2
        CustomText.secondaryDisplaySmall(
          tr(AppConstants.pleaseCheckYourNetwork),
          textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: AppFonts.regular,
                fontSize: AppSizes.h7,
              ),
        ),
        SizedBox(
          height: AppSizes.pH7,
        ),

        SizedBox(
          width: AppSizes.tryAgainButtonSize,
          child: CustomOutlinedButton(
              onPressed: () async {
                sl<ConnectivityService>().isConnected().then((value) {
                  if (value == ConnectivityResult.mobile ||
                      value == ConnectivityResult.wifi) {
                    NavigationService.goBack();
                  }
                });
              },
              text: tr(AppConstants.tryAgain)),
        )
      ],
    ));
  }
}
