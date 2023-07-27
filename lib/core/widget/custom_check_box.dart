import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_png_image.dart';


// ignore: must_be_immutable
class CustomCheckBox extends StatefulWidget {
  late bool isSelected;
  final bool isDisabled;

  final ValueChanged<bool> onChanged;
  final Widget? child;

  CustomCheckBox(
      {Key? key,
      this.isSelected = false,
      this.isDisabled = false,
      required this.onChanged,
      this.child})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!widget.isDisabled) {
          setState(() {
            isSelected = !isSelected;
            widget.onChanged(isSelected);
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: AppSizes.checkBoxSize,
            height: AppSizes.checkBoxSize,
            padding: EdgeInsets.only(
                top: AppSizes.checkBoxPaddingWidth,
                bottom: AppSizes.checkBoxPaddingWidth,
                left: AppSizes.checkBoxPaddingHight,
                right: AppSizes.checkBoxPaddingHight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.br4),
              gradient: isSelected ? ThemeColorLight.gradientMAinColor : null,
              border: isSelected ? null : Border.all(width: AppSizes.bs0_5),
            ),
            child: isSelected
                ? CustomPngImage.square(
                    path: AppAssets.checkBoxCheckedPng,
                  )
                : null,

            /*  child: Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                if (!widget.isDisabled) {
                  setState(() {
                    isSelected = value!;
                    widget.onChanged(value);
                  });
                }
              },

              // Background color of your checkbox if selected
              activeColor: ThemeColorLight.transparentColor,
              // Color of your check mark
              checkColor: ThemeColorLight.offWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                // ======> CHANGE THE BORDER COLOR HERE <======
                color: Theme.of(context).toggleButtonsTheme.borderColor!,
                // Give your checkbox border a custom width
                width: 1,
              ),
            ), */
          ),
          SizedBox(
            width: AppSizes.pW4,
          ),
          widget.child ?? const SizedBox(),
        ],
      ),
    );
  }
}

class CheckBoxDefaultText extends StatelessWidget {
  final String text;

  const CheckBoxDefaultText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText.secondaryDisplaySmall(
      text,
      textStyle: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(fontSize: AppSizes.h6, fontWeight: AppFonts.regular),
    );
  }
}
