import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/theme/theme_color/theme_color_dark.dart';
import '../global/theme/theme_color/theme_color_light.dart';
import '../utils/app_assets.dart';

import '../utils/app_fonts.dart';
import '../utils/app_sizes.dart';
import 'custom_gradient_text.dart';
import 'custom_text.dart';
import 'images/custom_svg_image.dart';



class CustomSnackBar {
  static showSnackBarSingleLine({
    String title = '',
    String description = '',
    Widget? mainButton,
    Duration duration = const Duration(seconds: 2),
    void Function(GetSnackBar)? onTap,
    DismissDirection? dismissDirection = DismissDirection.vertical,
  }) {
    Get.rawSnackbar(
        onTap: onTap,
        duration: duration,
        mainButton: mainButton,
        title: title,
        message: description,
        titleText: CustomText(
          title,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
          textStyle: Theme.of(Get.context!).textTheme.displaySmall!.copyWith(
              fontSize: AppSizes.h5,
              fontWeight: AppFonts.regular,
              color: ThemeColorDark.thirdColor),
        ),
        messageText: CustomText(description,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,
            textStyle: Theme.of(Get.context!).textTheme.displaySmall!.copyWith(
                fontSize: AppSizes.h7,
                fontWeight: AppFonts.regular,
                color: ThemeColorDark.thirdColor)),
        borderRadius: AppSizes.br12,
        margin: EdgeInsets.symmetric(horizontal: AppSizes.pH2),
        snackPosition: SnackPosition.TOP,
        shouldIconPulse: true,
        barBlur: 5,
        forwardAnimationCurve: Curves.easeInToLinear,
        reverseAnimationCurve: Curves.easeInOutBack,
        dismissDirection: dismissDirection);
  }

  static simpleSnackBar({
    String title = '',
    Duration duration = const Duration(seconds: 6),
    void Function(GetSnackBar)? onTap,
    required BuildContext context,
    DismissDirection? dismissDirection = DismissDirection.vertical,
  }) {
    Flushbar(
      message: title,
      messageText: CustomText(
        title,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: AppSizes.h5,
            fontWeight: AppFonts.regular,
            color: ThemeColorDark.thirdColor),
      ),
      margin: EdgeInsets.symmetric(horizontal: AppSizes.pW3),
      borderRadius: BorderRadius.circular(AppSizes.br12),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 6),
    ).show(context);
  }
}

class SnackBarActionText extends StatelessWidget {
  final String actionText;
  final void Function()? onTap;

  const SnackBarActionText({Key? key, required this.actionText, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: CustomGradientText(
          text: actionText,
          textStyle: TextStyle(
            fontSize: AppSizes.h5,
            fontWeight: AppFonts.regular,
            fontFamily: AppFonts.fontFamilyEnglish,
          ),
        ));
  }
}

class SnackBarCloseButton extends StatelessWidget {
  final void Function()? onTap;

  const SnackBarCloseButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomSvgImage.square(
        path: AppAssets.closeSquareSvg,

      
        color: ThemeColorLight.offWhite,
      ),
    );
  }
}
