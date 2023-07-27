import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';


import '../../global/theme/theme_color/theme_color_dark.dart';
import '../custom_gradient_box_border.dart';
import '../images/custom_avatar_image.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  bool isSelected;
  double? height;
  final Widget? widget;
  final String imageUrl;
  final String selectionIconPath;
  final String serviceNameTxt;
  final String serviceDurationTxt;
  final String servicePriceTxt;

  CustomCard(
      {Key? key,
      required this.isSelected,
      this.widget,
      this.height,
      required this.imageUrl,
      required this.selectionIconPath,
      required this.serviceNameTxt,
      required this.serviceDurationTxt,
      required this.servicePriceTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSizes.customCardH1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.br12),
          border: CustomGradientBoxBorder(
              gradient: ThemeColorLight.gradientMAinColor,
              width: AppSizes.bs1_0),
          color: ThemeColorLight.transparentColor),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Row(children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(
                  left: AppSizes.iconSize,
                  top: AppSizes.pH2,
                  bottom: AppSizes.pH2,
                  right: AppSizes.pH5),
              child: ClipOval(
                clipBehavior: Clip.antiAlias,
                child: isSelected
                    ? CustomSvgImage.icons(path: selectionIconPath)
                    : CustomAvatarImage(
                        imageUrl,
                        radius: AppSizes.imageWidthSmall,
                        width: AppSizes.imageWidthSmall,
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText.secondaryDisplaySmall(
                  serviceNameTxt,
                  maxLines: 1,
                  textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: ThemeColorDark.darkGray,
                        fontSize: AppSizes.h6,
                      ),
                ),
                CustomText.secondaryDisplaySmall(
                  serviceDurationTxt,
                  maxLines: 1,
                  textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: ThemeColorDark.grayScale,
                        fontSize: AppSizes.h7,
                      ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
                width: AppSizes.toggleButtonHeight,
                height: AppSizes.toggleButtonHeight,
                child: Center(
                  child: CustomText.secondaryDisplaySmall(
                    servicePriceTxt,
                    maxLines: 1,
                    textStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: ThemeColorDark.cardColor,
                              fontSize: AppSizes.h7,
                              height: 1.2,
                            ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
