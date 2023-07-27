import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/buttons/custom_text_button.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';


class CustomDualButtonDialog extends AlertDialog {
  CustomDualButtonDialog({
    Key? key,
    required BuildContext context,
    double? width,
    double? height,
    String? image,
    required Function() onPressed,
    required Function onPressed2,
    String? title,
    String? buttonText,
    String? buttonText2,
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
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            insetPadding:
                insetPadding ?? EdgeInsets.symmetric(horizontal: AppSizes.pW3),
            content: child ??
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (image != null)
                      CustomSvgImage(
                        path: image,
                      ),
                    SizedBox(
                      height: AppSizes.pW3,
                    ),
                    CustomText.thirdTitleSmall(
                      title!,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
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
                          child: CustomTextButton(
                            textButton: buttonText ?? tr('submit'),
                            onPressed: onPressed,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                fontSize: AppSizes.h6,
                                color: Theme.of(context).colorScheme.error),
                          )),
                    SizedBox(height: AppSizes.pH1,),
                    SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: buttonText2 ?? tr('submit'),
                          onPressed: onPressed2,
                        )),
                  ],
                ));
}
