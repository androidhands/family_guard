import 'package:flutter/material.dart';

import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/features/authentication/presentation/components/social_media_button_component.dart';
import 'package:family_guard/features/authentication/presentation/components/with_mail_component.dart';

import '../../../../core/widget/custom_text.dart';

class AuthenticationHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool hasSocialMedia;
  final bool isSignIn;

  const AuthenticationHeader({
    Key? key,
    required this.title,
    required this.subTitle,
    this.hasSocialMedia = true,
    required this.isSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppSizes.pH8, left: AppSizes.pH5, right: AppSizes.pH5),
      child: Column(
        children: [
          CustomText.primaryBodyLarge(
            title,
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: AppSizes.h4, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AppSizes.pH1,
          ),
          CustomText.primaryBodyLarge(
            subTitle,
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: AppSizes.h6, fontWeight: FontWeight.w400),
          ),
          if (hasSocialMedia)
            WithMailComponent(
              isSignIn: isSignIn,
            ),
          SizedBox(
            height: AppSizes.pH3,
          ),
          if (hasSocialMedia) SocialMediaButton(isSignIn: isSignIn),
        ],
      ),
    );
  }
}
