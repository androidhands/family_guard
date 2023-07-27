import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';

class WithMailComponent extends StatelessWidget {
  const WithMailComponent({Key? key, required this.isSignIn}) : super(key: key);
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.pH7, horizontal: AppSizes.pH3),
          child: CustomText.secondaryDisplaySmall(
            tr(AppConstants.orSocialSignIn),
            textStyle: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: AppSizes.h6, fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ],
    );
  }
}
