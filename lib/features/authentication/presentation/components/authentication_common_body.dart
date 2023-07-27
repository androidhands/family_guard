import 'package:flutter/material.dart';

import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/widget/custom_text.dart';

class AuthenticationCommonBody extends StatelessWidget {
  final String title;
  final Widget body;
  final bool isScrolling;
  final void Function()? backOnPress;
  final bool isSignIn;
  final void Function()? onLanguageChange;

  const AuthenticationCommonBody(
      {Key? key,
      required this.title,
      required this.body,
      this.isScrolling = false,
      this.backOnPress,
      this.onLanguageChange,
      this.isSignIn = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: isScrolling,
      body: SafeArea(
        top: false,
        child: Container(
          /*     decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  Provider.of<ThemeProvider>(context).appTheme == AppTheme.light
                      ? AppAssets.authBackground
                      : AppAssets.darkSplash),
              fit: BoxFit.fill,
            ),
          ), */
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          constraints: const BoxConstraints.expand(),
          child: isScrolling
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _BodyContainer(
                          isSignIn: isSignIn,
                          body: body,
                          backOnPress: backOnPress),
                      /*  LocalizationChangeWidget(
                          onLanguageChange: onLanguageChange), */
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _BodyContainer(
                      body: body,
                      backOnPress: backOnPress,
                      isSignIn: isSignIn,
                    ),
                    SizedBox(
                      height: AppSizes.pH8,
                    ),
                    /*   LocalizationChangeWidget(
                        onLanguageChange: onLanguageChange), */
                  ],
                ),
        ),
      ),
    );
  }
}

class _BodyContainer extends StatelessWidget {
  final Widget body;
  final bool isSignIn;
  final void Function()? backOnPress;

  const _BodyContainer(
      {Key? key, required this.body, this.backOnPress, required this.isSignIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSizes.pH8,
        ),
        Row(
          mainAxisAlignment: backOnPress == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            if (backOnPress != null)
              CustomBackButton(popOnPressed: backOnPress),
            CustomSvgImage(
              path: AppAssets.home,
              width: AppSizes.pW4,
              height: AppSizes.pH4,
            ),
            /* SizedBox(
              width: AppSizes.backIconSize + (AppSizes.pW5 * 2),
            ), */
          ],
        ),
        SizedBox(
          height: AppSizes.pH5,
        ),
        if (isSignIn)
          CustomText.primaryBodyLarge(
            tr(AppConstants.welcome),
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: AppSizes.h4,
                ),
          ),
        Padding(
          padding: EdgeInsets.all(AppSizes.pH5),
          child: Card(
            elevation: 7,
            margin: EdgeInsets.zero,
            shadowColor: Colors.black26,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.br12)),
              child: Container(
                padding: EdgeInsets.all(AppSizes.pH5),
                width: AppSizes.widthFullScreen,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: body,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
