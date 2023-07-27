import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_fonts.dart';

import '../utils/app_sizes.dart';

class CustomLink extends StatelessWidget {
  final String prefixText;
  final TextStyle? prefixStyle;
  final String linkText;
  final void Function()? linkAction;

  const CustomLink(
      {Key? key,
      required this.prefixText,
      required this.linkText,
      this.linkAction,
      this.prefixStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: linkAction,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: prefixText,
            style:prefixStyle?? Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: AppSizes.h6, fontWeight: AppFonts.regular)),
        if (prefixText.isNotEmpty)
          WidgetSpan(
            child: SizedBox(width: AppSizes.pW2),
          ),
        TextSpan(
          text: linkText,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontSize: AppSizes.h6, fontWeight: AppFonts.regular),
          recognizer: TapGestureRecognizer()..onTap = linkAction,
        ),
      ])),
    );
  }
}
