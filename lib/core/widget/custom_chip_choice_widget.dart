import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_cashed_network_image.dart';
import 'package:family_guard/core/widget/images/custom_png_image.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

// ignore: must_be_immutable
class CustomChipChoiceWidget extends StatefulWidget {
  final String title;
  late bool isSelected;
  final bool isCloseIcon;
  final String? imageUrl;
  final String? suffixPath;
  final String? prefixPath;
  Function(bool) onSelected;

  CustomChipChoiceWidget(
      {Key? key,
      required this.title,
      this.isSelected = false,
      this.imageUrl,
      this.suffixPath,
      this.prefixPath,
      this.isCloseIcon = false,
      required this.onSelected})
      : super(key: key);

  @override
  State<CustomChipChoiceWidget> createState() => _CustomChipChoiceWidgetState();
}

class _CustomChipChoiceWidgetState extends State<CustomChipChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.e2),
      child: ChoiceChip(
        selectedColor: Theme.of(context).primaryColor,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              widget.title,
              textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: AppSizes.h8,
                  color: widget.isSelected
                      ? ThemeColorLight.whiteColor
                      : ThemeColorLight.pinkColor),
            ),
            SizedBox(width: AppSizes.pH2),
            (widget.isCloseIcon)
                ? CustomSvgImage.icons(
                    path: AppAssets.closeCircle,
                    color:
                        (widget.isSelected) ? ThemeColorLight.offWhite : null,
                  )
                : const SizedBox()
          ],
        ),
        labelPadding: EdgeInsetsDirectional.only(start: AppSizes.pH2),
        selected: widget.isSelected,
        onSelected: (bool selected) {
          setState(() {
            widget.isSelected = selected;
          });
          widget.onSelected(selected);
        },
        avatar: (widget.isSelected && widget.imageUrl != null)
            ? CustomPngImage.square(
                path: AppAssets.trueWithBorderPng,
              )
            : getChipPrefixWidget(
                prefixPath: widget.prefixPath,
                imageUrl: widget.imageUrl,
              ),
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pW2, vertical: AppSizes.pH2),
      ),
    );
  }
}

Widget? getChipPrefixWidget(
    {String? prefixPath, String? imageUrl, bool? isSelected}) {
  assert(!(prefixPath != null && imageUrl != null));
  return imageUrl != null
      ? CustomCashedNetworkImage(
          imageUrl: imageUrl,
          height: AppSizes.pW8,
          width: AppSizes.pW8,
          radius: BorderRadius.circular(AppSizes.br20),
        )
      : prefixPath != null
          ? CustomSvgImage.square(
              path: prefixPath,
            )
          : null;
}
