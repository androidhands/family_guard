
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/theme/theme_color/theme_color_light.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/custom_text.dart';

class CustomTitleCard extends StatelessWidget {
  final String? title;
  const CustomTitleCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(title ?? '',
            textStyle: Theme.of(Get.context!)
                .textTheme
                .labelMedium!
                .copyWith(color: ThemeColorLight.pinkColor)),
        Divider(
          thickness: AppSizes.dividerThickness,
        )
      ],
    );
  }
}