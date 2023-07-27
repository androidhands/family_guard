import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

import '../images/custom_svg_image.dart';

class CustomSwitchOutlined extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? iconAsset;

  const CustomSwitchOutlined(
      {Key? key, required this.value, required this.onChanged, this.iconAsset})
      : super(key: key);

  @override
  CustomSwitchStateOutlined createState() => CustomSwitchStateOutlined();
}

class CustomSwitchStateOutlined extends State<CustomSwitchOutlined>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerLeft : Alignment.centerRight,
            end: widget.value ? Alignment.centerRight : Alignment.centerLeft)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: SizedBox(
            width: AppSizes.pW7,
            height: AppSizes.pH7,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.br50),
                    color: Theme.of(context).toggleButtonsTheme.selectedColor,
                    border: Border.all(
                      width: AppSizes.bs1_5,
                      color: ThemeColorLight.darkGray,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        _circleAnimation.value == Alignment.centerLeft
                            ? Padding(
                            padding: EdgeInsets.only(
                                right: AppSizes.pH6, left: 0),
                            child: null)
                            : Container(),
                        _circleAnimation.value == Alignment.centerRight
                            ? Padding(
                            padding: EdgeInsets.only(
                                right: 0, left: AppSizes.pH6),
                            child: null)
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: _circleAnimation.value == Alignment.centerLeft
                          ? AppSizes.pW3
                          : widget.value
                              ? AppSizes.pW6
                              : AppSizes.pW3,
                      height: _circleAnimation.value == Alignment.centerLeft
                          ? AppSizes.pW3
                          : widget.value
                              ? AppSizes.pW6
                              : AppSizes.pW3,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).toggleButtonsTheme.color),
                      child: widget.iconAsset == null
                          ? null
                          :
                          CustomSvgImage.icons(
                              path: widget.iconAsset!,
                              color: Theme.of(context).toggleButtonsTheme.color,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
