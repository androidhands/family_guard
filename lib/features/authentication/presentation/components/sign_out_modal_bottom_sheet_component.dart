import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../../core/controllers/main_provider.dart';
import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';
import '../../../../core/widget/buttons/custom_text_button.dart';
import '../../../../core/widget/custom_text.dart';


class SignOutModalBottomSheetComponent extends StatelessWidget {
  const SignOutModalBottomSheetComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, provider, widget) => Padding(
              padding: EdgeInsets.all(AppSizes.pH7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///title
                  CustomText.primaryBodyLarge(
                    tr(AppConstants.areYouSureYouWantToSignOut),
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: AppFonts.medium, fontSize: AppSizes.h6),
                  ),

                  ///sign out button
                  CustomTextButton(
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: AppSizes.h6, fontWeight: AppFonts.regular),
                      textButton: tr(AppConstants.signOut),
                      onPressed: () async {
                      //  await provider.signOut(context);
                      }),

                  ///cancel button
                  CustomElevatedButton(
                    onPressed: () {
                      NavigationService.goBack();
                    },
                    text: tr(AppConstants.cancel),
                  )
                ],
              ),
            ));
  }
}
