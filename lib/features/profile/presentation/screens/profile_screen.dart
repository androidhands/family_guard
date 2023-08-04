import 'package:family_guard/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/images/custom_avatar_image.dart';
import '../../../home/presentation/controller/home_control_provider.dart';
import '../components/profile_details_component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          CustomAppbar(
            title: tr(AppConstants.profile),
            withTransparent: true,
            withOutElevation: true,
            withMenu: true,
            actions: [SizedBox()],
            popOnPressed: () {
              NavigationService.goBack();
            },
          ),

          /// BODY
          Consumer<HomeControlProvider>(
            builder: (context, homeControlProvider, child) => Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pW5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Profile Image
                    CustomAvatarImage(
                      "",//refineImage(userData.profileImageUrl),
                      //
                      width: AppSizes.profileImageWidth,
                      height: AppSizes.profileImageWidth,
                    ),
                    SizedBox(height: AppSizes.pH2),

                    /// User Name
                    CustomText.primaryBodyLarge(
                        'Full Name',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                fontSize: AppSizes.h6,
                                fontWeight: AppFonts.medium)),

                    /// User Location
                  
                    SizedBox(height: AppSizes.pH5),

                  
                    SizedBox(height: AppSizes.pH8),
                    const ProfileDetailsComponent(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
