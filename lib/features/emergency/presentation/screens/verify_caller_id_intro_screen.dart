import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/emergency/presentation/controller/verify_caller_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyCallerIdIntroScreen extends StatelessWidget {
  const VerifyCallerIdIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => VerifyCallerIdProvider(verificationCode: ""),
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
                    child: Column(
                      children: [
                        CustomText(tr(AppConstants.emergencyIntro),
                            textAlign: TextAlign.start,
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: ThemeColorLight.pinkColor,
                                    fontSize: AppSizes.h5)),
                        CustomElevatedButton(
                            onPressed: () {
                              provider.addNewCallerId();
                            },
                            isLoading: provider.isloading,
                            text: 'I am Ready, Verify')
                      ],
                    ),
                  ),
                ));
          });
        });
  }
}
