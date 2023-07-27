import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/images/custom_svg_image.dart';

class TermsAndPrivacyPolicyScreen extends StatelessWidget {
  const TermsAndPrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: tr(AppConstants.signUpTermsAgreementLink),
          withMenu: true,
          actions: const [SizedBox()],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSizes.pH5),
              child: Card(
                elevation: 7,
                margin: EdgeInsets.zero,
                shadowColor: Colors.black26,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppSizes.br12)),
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.pH5),
                    width: AppSizes.widthFullScreen,
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppSizes.pH8,
                          ),
                          CustomSvgImage(
                            path: AppAssets.appLogo,
                            width: AppSizes.pW4,
                            height: AppSizes.pH4,
                          ),
                          SizedBox(
                            width: AppSizes.backIconSize + (AppSizes.pW5 * 2),
                          ),
                          SizedBox(
                            height: AppSizes.pH5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSizes.pH5,
            ),
          ],
        ));
  }
}
