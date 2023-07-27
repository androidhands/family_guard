
import 'package:flutter/material.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

class HeaderModalBottomSheetDefault extends StatelessWidget {
  final String title;

  const HeaderModalBottomSheetDefault({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppSizes.pH3, right: AppSizes.pH3, top: AppSizes.pH2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvgImage(
            path: AppAssets.lineModalBottomSheetSvg,
            height: AppSizes.lineBottomSheetModalHeight,
            radius: BorderRadius.zero,
            width: AppSizes.lineBottomSheetModalWidth,
          ),
          SizedBox(
            height: AppSizes.pH1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.secondaryDisplaySmall(
                title,
                textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold, fontSize: AppSizes.h6),
              ),
              IconButton(
                  onPressed: () {
                    NavigationService.goBack();
                  },
                  icon: CustomSvgImage.icons(
                    path: AppAssets.closeSquareSvg,
                    color: Theme.of(context).iconTheme.color,
                  )),
            ],
          ),
          SizedBox(
            height: AppSizes.pH2,
          ),
          Divider(
            height: 0,
            thickness: 0.1,
            color: Theme.of(context).tabBarTheme.unselectedLabelColor,
          ),
        ],
      ),
    );
  }
}
