import 'package:flutter/material.dart';


import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

import '../../../../core/utils/app_fonts.dart';

class ProfileItemComponent extends StatelessWidget {
  final String path;
  final String text;
  final Function()? onTap;

  const ProfileItemComponent(
      {Key? key, required this.path, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CustomSvgImage.icons(
            path: path,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: AppSizes.pW2),
          CustomText.primaryBodyLarge(text,
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: AppSizes.h6,
                    fontWeight: AppFonts.regular,
                  )),
          const Expanded(child: SizedBox()),
        
        ],
      ),
    );
  }
}
