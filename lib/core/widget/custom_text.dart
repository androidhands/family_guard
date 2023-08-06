import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    required this.textStyle,
    this.defaultTextStyle,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  /// 1. Display Bold pink
  CustomText.pinkBold(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.displayLarge,
        );

  /// 2. Display Small
  CustomText.secondaryDisplaySmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextDirection? textDirection,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textDirection: textDirection,
          textStyle: textStyle ?? Get.theme.textTheme.displaySmall,
        );

  /// 3. Body Large gray
  CustomText.primaryBodyLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.bodyLarge,
        );

  /// 4. Body Small GrayScale
  CustomText.thirdTitleSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.titleSmall,
        );

  /// 5. Body Small GrayScale
  CustomText.successTitleMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.titleMedium,
        );

  /// 6. Error
  CustomText.errorLabelSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.labelSmall,
        );

  /// 7. Info Text
  CustomText.infoDisplayMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.displayMedium,
        );

  /// 8. Warning Text
  CustomText.warningHeadline(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.headlineSmall,
        );

  /// 9. White Text
  CustomText.whiteBodySmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.bodySmall,
        );

  /// 10. OffWhite Text
  CustomText.offWhiteBodyMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle ?? Get.theme.textTheme.bodyMedium,
        );

  ///////////////////////////////////////////////////////////////////////

  final String text;
  final TextStyle? textStyle;
  final int? defaultTextStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? getDefaultTextStyle(context, defaultTextStyle!),
      textAlign: textAlign ?? TextAlign.center,
      textDirection: textDirection,
      overflow: overflow,
      maxLines: maxLines,
    

    );
  }

  getDefaultTextStyle(BuildContext context, int defaultTextStyle) {
    switch (defaultTextStyle) {
      case 0:
        {
          return Theme.of(context).textTheme.displayLarge;
        }
      case 1:
        {
          return Theme.of(context).textTheme.displaySmall;
        }
      case 2:
        {
          return Theme.of(context).textTheme.bodyLarge;
        }
      case 3:
        {
          return Theme.of(context).textTheme.titleSmall;
        }
      case 4:
        {
          return Theme.of(context).textTheme.titleSmall;
        }
      case 5:
        {
          return Theme.of(context).textTheme.labelSmall;
        }
      case 6:
        {
          return Theme.of(context).textTheme.displayMedium;
        }
      case 7:
        {
          return Theme.of(context).textTheme.headlineSmall;
        }
      case 8:
        {
          return Theme.of(context).textTheme.bodySmall;
        }
      case 9:
        {
          return Theme.of(context).textTheme.bodyMedium;
        }
    }
  }
}
