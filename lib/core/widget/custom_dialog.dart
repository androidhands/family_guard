import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';

class CustomDialog extends AlertDialog {
  CustomDialog({
    Key? key,
    required BuildContext context,
    double? width,
    double? height,
    String? image,
    required Function onPressed,
    Function? onPressed2,
    String? title,
    String? buttonText,
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleTextStyle,
    String description = '',
    List<Widget>? actions,
    EdgeInsets? insetPadding,
    EdgeInsets? contentPadding,
    Clip clipBehavior = Clip.none,
    ShapeBorder? shape,
    Widget? child,
  }) : super(
            key: key,
            shape: shape,
            // contentPadding:
            //     EdgeInsets.only(
            //       bottom: AppSizes.pW6,
            //     ),
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            insetPadding:
                insetPadding ?? EdgeInsets.symmetric(horizontal: AppSizes.pW3),
            content: child ??
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Align(
                    //     alignment: Alignment.topRight,
                    //     child: CustomSvgImage.icons(
                    //       path: AppAssets.closeDialogButtonSvg,
                    //       color: Theme.of(context).iconTheme.color,
                    //     )),
                    if (image != null)
                      CustomSvgImage.square(
                        path: image,
                      ),
                    SizedBox(
                      height: AppSizes.pW3,
                    ),
                    CustomText.secondaryDisplaySmall(
                      title!,
                      textStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                              fontWeight: AppFonts.semiBold,
                              fontSize: AppSizes.h5),
                    ),
                    SizedBox(
                      height: AppSizes.pH4,
                    ),
                    child ?? const SizedBox(),
                    if (actions != null)
                      ...List.generate(
                          actions.length, (index) => actions[index]),
                    if (actions == null)
                      SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            text: buttonText ?? tr('submit'),
                            onPressed: onPressed,
                          ))
                  ],
                ));
}
