import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widget/custom_text.dart';

class CustomMyDetailsWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool hasDevider;

  const CustomMyDetailsWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.hasDevider});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: AppSizes.pW5, top: AppSizes.pW5, bottom: AppSizes.pW5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.thirdTitleSmall(
                title,
                textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: AppFonts.medium,
                      fontSize: AppSizes.h7,
                    ),
              ),
              SizedBox(
                height: AppSizes.pH3,
              ),
              CustomText.secondaryDisplaySmall(
                subTitle,
                textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: AppSizes.h6, fontWeight: AppFonts.regular),
              ),
            ],
          ),
        ),
        if (hasDevider)
          Divider(
            thickness: 1,
            color: Theme.of(context).dividerColor,
          )
      ],
    );
  }
}
