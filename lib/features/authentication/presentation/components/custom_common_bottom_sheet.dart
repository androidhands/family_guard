import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';



import '../../../../core/services/navigation_service.dart';


class CustomCommonBottomSheet extends StatelessWidget {
  final List<Widget> children;
  final Function(int index) onSelectedIndex;

  const CustomCommonBottomSheet(
      {Key? key, required this.children, required this.onSelectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.pW5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppSizes.iconSize,
              ),
              SizedBox(
                width: AppSizes.sizedBoxW2,
                child: Divider(
                  thickness: 3,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    NavigationService.goBack();
                  },
                  child: CustomSvgImage(
                    path: AppAssets.closeSquareSvg,
                    width: AppSizes.iconSize,
                    height: AppSizes.iconSize,
                    color: Theme.of(context).iconTheme.color,
                  )),
            ],
          ),
          SizedBox(
            height: AppSizes.pH8,
          ),
          Column(
            children: List.generate(
              children.length,
              (index) => InkWell(
                onTap: () => onSelectedIndex(index),
                child: Container(
                  height: AppSizes.dropDownButtonSize,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  decoration: index == children.length - 1
                      ? null
                      : BoxDecoration(
                          border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .border!
                                  .borderSide
                                  .color),
                        )),
                  child: children[index],
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSizes.pH8,
          ),
        ]),
      ),
    );
  }
}
