import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_boder_icon.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/features/authentication/presentation/utils/enums.dart';
import 'package:family_guard/features/authentication/presentation/utils/utils.dart';
import 'dart:io' show Platform;

class SocialMediaButton extends StatefulWidget {
  final bool isSignIn;

  const SocialMediaButton({Key? key, required this.isSignIn}) : super(key: key);

  @override
  State<SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<SocialMediaButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CustomLoadingIndicators.loadingAnimation(
            size: AppSizes.loadingIndicatorFOrSocialMediaSize)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                Platform.isAndroid
                    ? socialMediaLogoPath.length - 1
                    : socialMediaLogoPath.length,
                (index) => InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        widget.isSignIn
                            ? await socialMediaActionSignIn[index]?.call()
                            : await socialMediaActionSignUp[index]?.call();

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: CustomBorderIcon(
                        width: AppSizes.socialMediaButtonSize,
                        height: AppSizes.socialMediaButtonSize,
                        containerColor: Theme.of(context).colorScheme.background,
                        path: socialMediaLogoPath[
                            SocialMediaOptions.values[index]]!,
                      ),
                    )),
          );
  }
}
