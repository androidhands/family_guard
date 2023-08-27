import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';

class NotificationGroupSeparatorWidget extends StatelessWidget {
  final String text;

  const NotificationGroupSeparatorWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSizes.pH7, left: AppSizes.pH8),
      child: CustomText.secondaryDisplaySmall(
        text,
        textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: AppSizes.h4,
              fontWeight: AppFonts.bold,
            ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
