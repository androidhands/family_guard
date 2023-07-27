import 'package:flutter/material.dart';

import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/features/authentication/presentation/components/social_media_button_component.dart';
import 'package:family_guard/features/authentication/presentation/components/with_mail_component.dart';

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
