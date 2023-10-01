import 'package:family_guard/features/profile/presentation/controllers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/global/theme/theme_color/theme_color_light.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../widgets/custom_my_details_widget.dart';

class MyDetailsScreen extends StatelessWidget {
  const MyDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: tr(AppConstants.myDetails),
        withTransparent: false,
        withOutElevation: true,
        withMenu: true,
        actions: const [SizedBox()],
        popOnPressed: () {
          NavigationService.goBack();
        },
        popIconsColor: ThemeColorLight.pinkColor,
      ),
      body: ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
          builder: (context, child) {
            return Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return Padding(
                  padding: EdgeInsets.all(AppSizes.pW5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomMyDetailsWidget(
                        title: tr(AppConstants.firstNameProfile),

                        ///TODO Abdelhamid : use default value for parameter instead or repeating the check
                        ///Done
                        subTitle: provider.user.firstName,
                        hasDevider: true,
                      ),
                      CustomMyDetailsWidget(
                        title: tr(AppConstants.lastNameProfile),
                        subTitle: provider.user.secondName,
                        hasDevider: true,
                      ),
                      CustomMyDetailsWidget(
                        title: tr(AppConstants.familyNameProfile),
                        subTitle: provider.user.familyName,
                        hasDevider: true,
                      ),
                      CustomMyDetailsWidget(
                        title: tr(AppConstants.mobileNumber),
                        subTitle: provider.user.mobile,
                        hasDevider: true,
                      ),
                      CustomMyDetailsWidget(
                        title: tr(AppConstants.emailAddress),
                        subTitle: provider.user.email,
                        hasDevider: false,
                      ),
                      /*   CustomMyDetailsWidget(
                        title: tr(AppConstants.gender),
                        subTitle: provider.user.gender == "0"
                            ? tr(AppConstants.male)
                            : tr(AppConstants.female),
                        hasDevider: false,
                      ), */
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

class AppConstance {}
