import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/emergency/presentation/controller/verify_caller_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewCallerIdScreen extends StatelessWidget {
  final String verifyCode;

  const AddNewCallerIdScreen({Key? key, required this.verifyCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            VerifyCallerIdProvider(verificationCode: verifyCode),
        builder: (context, child) {
          return Consumer<VerifyCallerIdProvider>(
              builder: (context, provider, child) {
            return Scaffold(
                appBar: CustomAppbar(
                  title: tr(AppConstants.emergencyVerification),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppSizes.pH9,
                          ),
                          CustomSvgImage.square(path: AppAssets.incominCall),
                          SizedBox(
                            height: AppSizes.pH9,
                          ),
                          Center(
                            child: CustomText(
                                tr(AppConstants.incomingCallMessage),
                                textAlign: TextAlign.center,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: ThemeColorLight.pinkColor,
                                        fontSize: AppSizes.h5,
                                        fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: AppSizes.pH9,
                          ),
                          Center(
                            child: CustomText(provider.verificationCode,
                                textAlign: TextAlign.start,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: ThemeColorLight.blackColor,
                                        fontSize: AppSizes.h1,
                                        fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: AppSizes.pH9,
                          ),
                          CustomElevatedButton(
                              onPressed: () {
                                provider.checkVeriviedCallerId();
                              },
                              isLoading: provider.isloading,
                              text: 'I added the code successfully'),
                        ],
                      ),
                    ),
                  ),
                ));
          });
        });
  }
}
